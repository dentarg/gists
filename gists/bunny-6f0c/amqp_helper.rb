require "securerandom"
require "bunny"

class AmqpHelper
  def self.publish(queue_name)
    conn = Bunny.new
    conn.start

    ch = conn.create_channel
    q  = ch.queue(queue_name)
    x  = ch.default_exchange

    x.publish("Hello!", :routing_key => q.name)

    sleep 0.5
    conn.close
  end

  def self.peak(queue_name)
    # Start a communication session with RabbitMQ
    conn = Bunny.new
    conn.start

    # open a channel
    ch = conn.create_channel

    # declare a queue
    q  = ch.queue(queue_name)

    # fetch a message from the queue
    delivery_info, metadata, payload = q.pop

    peak = q.pop

    require "pp"
    pp q.pop.any?
    p "---"
    pp delivery_info
    p "---"
    pp metadata
    p "---"
    pp payload

    puts "This is the message: #{payload}"

    # close the connection
    conn.stop

    peak
  end

  def self.remove_queue(queue_name)
    conn = Bunny.new
    conn.start
    ch = conn.create_channel
    ch.queue_delete(queue_name)
    conn.close
  end
end

queue_name = "test.#{SecureRandom.hex}"

AmqpHelper.publish(queue_name)
puts "published to queue: #{queue_name}"

AmqpHelper.peak(queue_name)
puts "consumed from queue: #{queue_name}"

AmqpHelper.remove_queue(queue_name + "a")
puts "removed queue: #{queue_name}"
