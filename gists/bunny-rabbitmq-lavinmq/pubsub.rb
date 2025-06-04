require "bundler/inline"

gemfile(true) do
  source "https://rubygems.org"
  # gem "bunny", "2.23.0"
  gem "bunny", path: "/Users/dentarg/src/bunny"
  gem "excon"
  gem "json"
  gem "set"
end

def with_amqp_connection
  amqp_mgmt_scheme = ENV.fetch("AMQP_MGMT_SCHEME", "http")
  amqp_mgmt_host = ENV.fetch("AMQP_MGMT_HOST", "localhost")
  amqp_mgmt_port = ENV.fetch("AMQP_MGMT_PORT", 15672)
  amqp_scheme = ENV.fetch("AMQP_SCHEME", "amqp")
  amqp_host = ENV.fetch("AMQP_HOST", "localhost")
  amqp_port = ENV.fetch("AMQP_PORT", 5672)

  vhost_name = "test_#{SecureRandom.hex(4)}"
  mgmt_url = "#{amqp_mgmt_scheme}://#{amqp_mgmt_host}:#{amqp_mgmt_port}"
  amqp_url = "#{amqp_scheme}://#{amqp_host}:#{amqp_port}/#{vhost_name}"
  path = "/api/vhosts/#{vhost_name}"
  user = "guest"
  password = "guest"

  Excon.put(mgmt_url, path:, user:, password:)
  options = { heartbeat: 60 }
  options.merge!(log_level: :debug) if ENV["DEBUG"] == "1"
  bunny = Bunny.new(amqp_url, options)
  bunny.start

  yield bunny
ensure
  puts "closing AMQP connection"
  bunny.close
  Excon.delete(mgmt_url, path:, user:, password:)
end

class Amqp
  def initialize(bunny)
    @amqp = bunny
  end

  def with_channel(*args)
    yield Group.new(@amqp, *args)
  end

  def subscribe(*args, &blk)
    with_channel { |ch| ch.subscribe(*args, &blk) }
  end

  def publish(*args)
    pub_group.publish(*args)
  end

  def pub_group
    @pub_group ||= Group.new(@amqp)
  end

  class Group
    def initialize(amqp, *args)
      @ch_args = args
      @amqp = amqp
      init_group
    end

    def init_group(close: true)
      @ch&.close if close
      @ch = create_channel(*@ch_args)
      @t = @ch.topic "amq.topic", durable: true
    end

    def create_channel(prefetch: 2)
      ch = @amqp.create_channel(nil, prefetch)
      ch.prefetch prefetch
      ch.confirm_select
      ch
    end

    def subscribe(qname, *topics, republish_on_error: false, block: false, log: true, arguments: {})
      q = declare_queue(qname, *topics, arguments:)
      q.subscribe(manual_ack: true, block:, exclusive: true) do |delivery, properties, data|
        topic = delivery.routing_key
        puts "<= #{topic} #{qname} #{data}" if log

        yield data, properties, topic

        @ch.acknowledge(delivery.delivery_tag, false)
      rescue => e
        puts e.full_message
      end
    end

    def declare_queue(qname, *topics, arguments: {})
      t = @ch.topic "amq.topic", durable: true
      q = @ch.queue(qname, durable: true, arguments:)
      topics.each do |topic|
        q.bind(t, routing_key: topic)
      end
      q
    end

    def publish(topic, data, opts: false, log: true)
      puts "=> #{topic} #{data}" if log
      @t.publish data.to_json, {
        routing_key: topic,
        persistent: true,
        content_type: "application/json",
      }.merge(opts || {})
      success = @ch.wait_for_confirms
      raise "at=error error=publish reason=not-confirmed" unless success
    end
  end
end

with_amqp_connection do |bunny|
  amqp = Amqp.new(bunny)

  queue_name = "test_queue_name"
  routing_key = "test_routing_key"
  topic = routing_key
  message = "this is the data"

  consumed_data = nil
  consumed_properties = nil
  consumed_topic = nil

  block = ENV["BLOCK"] == "1"

  puts "subscribe will block" if block

  mutex = Mutex.new
  resource = ConditionVariable.new

  amqp.subscribe(queue_name, routing_key, block:) do |data, properties, topic|
    puts "subscribe data=#{data.class}"
    puts "subscribe data=#{data.inspect}"

    consumed_data, consumed_properties, consumed_topic = [data, properties, topic]

    mutex.synchronize { resource.signal }
  end

  amqp.publish(topic, message)
  mutex.synchronize { resource.wait(mutex) }

  puts "published message: #{message}"
  puts ["received", consumed_data, consumed_properties, consumed_topic].map(&:inspect)
end
