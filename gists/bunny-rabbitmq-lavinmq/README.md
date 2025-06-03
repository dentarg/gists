# LavinMQ

Start LavinMQ in Docker

```shell
$ docker run --rm -it -p 5674:5672 -p 15674:15672 cloudamqp/lavinmq:2.3.0
WARNING: 'guest_only_loopback' is deprecated, use '--default-user-only-loopback' instead
WARNING: 'guest_only_loopback' is deprecated, use '--default-user-only-loopback' instead
2025-06-03T15:10:03.841578Z  INFO lmq[level: "Info", target: "stdout"] Logger settings
2025-06-03T15:10:03.841792Z  INFO lmq.launcher LavinMQ 2.3.0
2025-06-03T15:10:03.841804Z  INFO lmq.launcher Crystal 1.16.0 [53cead6] (2025-04-09)
2025-06-03T15:10:03.841810Z  INFO lmq.launcher LLVM: 18.1.3
2025-06-03T15:10:03.841837Z  INFO lmq.launcher Default target: aarch64-unknown-linux-gnu
2025-06-03T15:10:03.841848Z  INFO lmq.launcher Build flags: --release --debug
2025-06-03T15:10:03.841854Z  INFO lmq.launcher Pid: 1
2025-06-03T15:10:03.841862Z  INFO lmq.launcher Data directory: /var/lib/lavinmq
2025-06-03T15:10:03.841884Z  INFO lmq.launcher Max mmap count: 262144
2025-06-03T15:10:03.841898Z  INFO lmq.launcher FD limit: 1048576
2025-06-03T15:10:03.845280Z  INFO lmq.vhost[vhost: "/"] Loading default definitions
2025-06-03T15:10:03.845319Z  INFO lmq.vhost[vhost: "/"] Compacting definitions
2025-06-03T15:10:03.846015Z  INFO lmq.vhost_store Created vhost /
2025-06-03T15:10:03.847302Z  INFO lmq.http.server Bound to 0.0.0.0:15672
2025-06-03T15:10:03.848061Z  INFO lmq.http.server Bound to /tmp/lavinmqctl.sock
2025-06-03T15:10:03.848183Z  INFO lmq.server Listening for AMQP on 0.0.0.0:5672
2025-06-03T15:10:03.848223Z  INFO lmq.server Listening for MQTT on 0.0.0.0:1883
2025-06-03T15:10:03.849220Z  INFO lmq.launcher Finished startup in 0.007255709s
2025-06-03T15:10:10.698778Z  INFO lmq.vhost[vhost: "test_126a55a1"] Loading default definitions
2025-06-03T15:10:10.698932Z  INFO lmq.vhost[vhost: "test_126a55a1"] Compacting definitions
2025-06-03T15:10:10.701468Z  INFO lmq.vhost_store Created vhost test_126a55a1
2025-06-03T15:10:10.707626Z  INFO lmq.amqp.client[vhost: "test_126a55a1", address: "192.168.65.1:40974"] Connection established for user=guest
2025-06-03T15:10:10.710530Z  INFO lmq.message_store[queue: "test_queue_name", vhost: "test_126a55a1"] Loaded 1 segments, 0 messages
2025-06-03T15:10:10.715827Z  INFO lmq.amqp.client[vhost: "test_126a55a1", address: "192.168.65.1:40974"] Connection disconnected for user=guest
2025-06-03T15:10:10.717333Z  INFO lmq.vhost[vhost: "test_126a55a1"] Closing connections
2025-06-03T15:10:10.717376Z  INFO lmq.vhost[vhost: "test_126a55a1"] All connections closed gracefully
2025-06-03T15:10:10.722669Z  INFO lmq.vhost_store Deleted vhost test_126a55a1
```

Run the Ruby program against LavinMQ

```shell
$ AMQP_MGMT_PORT=15674 AMQP_PORT=5674 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
=> test_routing_key this is the data
published message: this is the data
"received"
nil
nil
nil
closing AMQP connection
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
/Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/session.rb:1119:in 'Bunny::Session#send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x0000000117c97530 @payload="\x00<\x00P\x00\x00\x00\x00\x00\x00\x00\x01\x00", @channel=1>, method class is AMQ::Protocol::Basic::Ack (Bunny::ConnectionClosedError)
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:881:in 'block in Bunny::Channel#basic_ack'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:2163:in 'Bunny::Channel#guarding_against_stale_delivery_tags'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:879:in 'Bunny::Channel#basic_ack'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:593:in 'Bunny::Channel#ack'
  from pubsub.rb:86:in 'block in Amqp::Group#subscribe'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer.rb:58:in 'Bunny::Consumer#call'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:1893:in 'block in Bunny::Channel#handle_frameset'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:110:in 'block (2 levels) in Bunny::ConsumerWorkPool#run_loop'
  from <internal:kernel>:168:in 'Kernel#loop'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:105:in 'block in Bunny::ConsumerWorkPool#run_loop'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:104:in 'Kernel#catch'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:104:in 'Bunny::ConsumerWorkPool#run_loop'
```

What LavinMQ is logging

```
2025-06-03T15:12:02.897583Z  INFO lmq.vhost[vhost: "test_d32f8ee7"] Loading default definitions
2025-06-03T15:12:02.897731Z  INFO lmq.vhost[vhost: "test_d32f8ee7"] Compacting definitions
2025-06-03T15:12:02.900257Z  INFO lmq.vhost_store Created vhost test_d32f8ee7
2025-06-03T15:12:02.906511Z  INFO lmq.amqp.client[vhost: "test_d32f8ee7", address: "192.168.65.1:63190"] Connection established for user=guest
2025-06-03T15:12:02.910339Z  INFO lmq.message_store[queue: "test_queue_name", vhost: "test_d32f8ee7"] Loaded 1 segments, 0 messages
2025-06-03T15:12:02.915204Z  INFO lmq.amqp.client[vhost: "test_d32f8ee7", address: "192.168.65.1:63190"] Connection disconnected for user=guest
2025-06-03T15:12:02.916812Z  INFO lmq.vhost[vhost: "test_d32f8ee7"] Closing connections
2025-06-03T15:12:02.916855Z  INFO lmq.vhost[vhost: "test_d32f8ee7"] All connections closed gracefully
2025-06-03T15:12:02.921506Z  INFO lmq.vhost_store Deleted vhost test_d32f8ee7
```

The `block` argument to `subscribe` does not seem to matter.

```shell
$ BLOCK=1 AMQP_MGMT_PORT=15674 AMQP_PORT=5674 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
subscribe will block
=> test_routing_key this is the data
published message: this is the data
"received"
nil
nil
nil
closing AMQP connection
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
/Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/session.rb:1119:in 'Bunny::Session#send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x000000012fff9e40 @payload="\x00<\x00P\x00\x00\x00\x00\x00\x00\x00\x01\x00", @channel=1>, method class is AMQ::Protocol::Basic::Ack (Bunny::ConnectionClosedError)
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:881:in 'block in Bunny::Channel#basic_ack'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:2163:in 'Bunny::Channel#guarding_against_stale_delivery_tags'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:879:in 'Bunny::Channel#basic_ack'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:593:in 'Bunny::Channel#ack'
  from pubsub.rb:86:in 'block in Amqp::Group#subscribe'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer.rb:58:in 'Bunny::Consumer#call'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/channel.rb:1893:in 'block in Bunny::Channel#handle_frameset'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:110:in 'block (2 levels) in Bunny::ConsumerWorkPool#run_loop'
  from <internal:kernel>:168:in 'Kernel#loop'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:105:in 'block in Bunny::ConsumerWorkPool#run_loop'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:104:in 'Kernel#catch'
  from /Users/dentarg/.arm64_rubies/3.4.3/lib/ruby/gems/3.4.0/gems/bunny-2.24.0/lib/bunny/consumer_work_pool.rb:104:in 'Bunny::ConsumerWorkPool#run_loop'
```

What RabbitMQ is logging with `--debug`

```
2025-06-03T15:28:16.536267Z  INFO lmq.http.server 192.168.65.1 - GET /api/vhosts?page=1&page_size=100 HTTP/1.1 - 200 (549.21µs)
2025-06-03T15:28:16.542093Z  INFO lmq.http.server 192.168.65.1 - GET /api/vhosts/%2F/permissions HTTP/1.1 - 200 (236.54µs)
2025-06-03T15:28:21.354506Z DEBUG lmq.parameter_store[vhost: "test_40b36b31"] 0 items loaded from operator_policies.json
2025-06-03T15:28:21.354598Z DEBUG lmq.parameter_store[vhost: "test_40b36b31"] 0 items loaded from policies.json
2025-06-03T15:28:21.354705Z DEBUG lmq.parameter_store[vhost: "test_40b36b31"] 0 items loaded from parameters.json
2025-06-03T15:28:21.354760Z  INFO lmq.vhost[vhost: "test_40b36b31"] Loading default definitions
2025-06-03T15:28:21.354836Z  INFO lmq.vhost[vhost: "test_40b36b31"] Compacting definitions
2025-06-03T15:28:21.357914Z  INFO lmq.vhost_store Created vhost test_40b36b31
2025-06-03T15:28:21.357959Z DEBUG lmq.user_store Saving users to file
2025-06-03T15:28:21.359390Z DEBUG lmq.user_store Saving users to file
2025-06-03T15:28:21.360537Z DEBUG lmq.vhost_store Saving vhosts to file
2025-06-03T15:28:21.362070Z DEBUG lmq.retainstore restoring index
2025-06-03T15:28:21.362146Z DEBUG lmq.retainstore restoring index done, msg_count = 0
2025-06-03T15:28:21.362239Z  INFO lmq.http.server 192.168.65.1 - PUT /api/vhosts/test_40b36b31 HTTP/1.1 - 201 (8.32ms)
2025-06-03T15:28:21.373803Z  INFO lmq.amqp.client[vhost: "test_40b36b31", address: "192.168.65.1:21507"] Connection established for user=guest
2025-06-03T15:28:21.378905Z DEBUG lmq.message_store[queue: "test_queue_name", vhost: "test_40b36b31"] Loading 0 ack files
2025-06-03T15:28:21.378992Z DEBUG lmq.message_store[queue: "test_queue_name", vhost: "test_40b36b31"] Loaded 0 ack files
2025-06-03T15:28:21.379055Z DEBUG lmq.message_store[queue: "test_queue_name", vhost: "test_40b36b31"] Loading 1 segments
2025-06-03T15:28:21.379730Z  INFO lmq.message_store[queue: "test_queue_name", vhost: "test_40b36b31"] Loaded 1 segments, 0 messages
2025-06-03T15:28:21.379867Z DEBUG lmq.vhost[vhost: "test_40b36b31"] Storing definition: AMQ::Protocol::Frame::Queue::Declare(@channel=1, @bytesize=27, @reserved1=0, @queue_name="test_queue_name", @passive=false, @durable=true, @exclusive=false, @auto_delete=false, @no_wait=false, @arguments=AMQ::Protocol::Table())
2025-06-03T15:28:21.382023Z DEBUG lmq.vhost[vhost: "test_40b36b31"] Storing definition: AMQ::Protocol::Frame::Queue::Bind(@channel=1, @bytesize=54, @reserved1=0, @queue_name="test_queue_name", @exchange_name="amq.topic", @routing_key="test_routing_key", @no_wait=false, @arguments=AMQ::Protocol::Table())
2025-06-03T15:28:21.383695Z DEBUG lmq.vhost[vhost: "test_40b36b31"] Storing definition: AMQ::Protocol::Frame::Queue::Bind(@channel=1, @bytesize=51, @reserved1=0, @queue_name="test_queue_name", @exchange_name="amq.topic", @routing_key="{block: true}", @no_wait=false, @arguments=AMQ::Protocol::Table())
2025-06-03T15:28:21.385133Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Adding consumer (now 1)
2025-06-03T15:28:21.385222Z DEBUG lmq.amqp.consumer[consumer: "bunny-1748964501000-769829877309", client: "192.168.65.1:21507", channel: 1] The queue isn't a single active consumer queue
2025-06-03T15:28:21.385281Z DEBUG lmq.amqp.consumer[consumer: "bunny-1748964501000-769829877309", client: "192.168.65.1:21507", channel: 1] Waiting for queue not to be empty
2025-06-03T15:28:21.386418Z DEBUG lmq.amqp.consumer[consumer: "bunny-1748964501000-769829877309", client: "192.168.65.1:21507", channel: 1] Queue is not empty
2025-06-03T15:28:21.386481Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Counting as unacked: 00000000010000000004
2025-06-03T15:28:21.386546Z DEBUG lmq.amqp.consumer[consumer: "bunny-1748964501000-769829877309", client: "192.168.65.1:21507", channel: 1] Waiting for queue not to be empty
2025-06-03T15:28:21.386778Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Removing consumer with 1 unacked messages (0 consumers left)
2025-06-03T15:28:21.386844Z DEBUG lmq.amqp.channel[client: "192.168.65.1:21507", channel: 1] Requeing unacked msg 00000000010000000004
2025-06-03T15:28:21.386865Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Rejecting 00000000010000000004, requeue: true
2025-06-03T15:28:21.386902Z DEBUG lmq.amqp.channel[client: "192.168.65.1:21507", channel: 1] Closed
2025-06-03T15:28:21.386987Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Checking if message LavinMQ::BytesMessage(@timestamp=1748964501300, @exchange_name="amq.topic", @routing_key="test_routing_key", @properties=AMQ::Protocol::Properties(@timestamp_raw=nil, @content_type="application/json", @content_encoding=nil, @headers=nil, @delivery_mode=2, @priority=0, @correlation_id=nil, @reply_to=nil, @expiration=nil, @message_id=nil, @type=nil, @user_id=nil, @app_id=nil, @reserved1=nil), @bodysize=18, @body=Bytes[34, 116, 104, 105, 115, 32, 105, 115, 32, 116, 104, 101, 32, 100, 97, 116, 97, 34]) has to be expired
2025-06-03T15:28:21.387039Z DEBUG lmq.amqp.consumer[consumer: "bunny-1748964501000-769829877309", client: "192.168.65.1:21507", channel: 1] deliver loop exiting: #<Channel::ClosedError:Channel is closed>
2025-06-03T15:28:21.387250Z DEBUG lmq.amqp.channel[client: "192.168.65.1:21507", channel: 2] Closed
2025-06-03T15:28:21.387522Z DEBUG lmq.amqp.client[vhost: "test_40b36b31", address: "192.168.65.1:21507"] Client disconnected: Goodbye
2025-06-03T15:28:21.387921Z  INFO lmq.amqp.client[vhost: "test_40b36b31", address: "192.168.65.1:21507"] Connection disconnected for user=guest
2025-06-03T15:28:21.389226Z DEBUG lmq.user_store Saving users to file
2025-06-03T15:28:21.390837Z  INFO lmq.vhost[vhost: "test_40b36b31"] Closing connections
2025-06-03T15:28:21.390880Z DEBUG lmq.vhost[vhost: "test_40b36b31"] Close sent to all connections
2025-06-03T15:28:21.390917Z  INFO lmq.vhost[vhost: "test_40b36b31"] All connections closed gracefully
2025-06-03T15:28:21.392896Z DEBUG lmq.queue[queue: "test_queue_name", vhost: "test_40b36b31"] Closed
2025-06-03T15:28:21.395057Z  INFO lmq.vhost_store Deleted vhost test_40b36b31
2025-06-03T15:28:21.395075Z DEBUG lmq.vhost_store Saving vhosts to file
2025-06-03T15:28:21.396011Z  INFO lmq.http.server 192.168.65.1 - DELETE /api/vhosts/test_40b36b31 HTTP/1.1 - 204 (6.85ms)
```




# RabbitMQ

Start RabbitMQ in Docker

```shell
docker run --rm -it -p 5673:5672 -p 15673:15672 rabbitmq:4.1.0-management
```

Run the Ruby program against RabbitMQ

```shell
$ AMQP_MGMT_PORT=15673 AMQP_PORT=5673 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/...
Resolving dependencies...
Using bundler 2.4.7
Using rbtree 0.4.6
Using set 1.1.2
Using logger 1.7.0
Using json 2.12.2
Using sorted_set 1.0.3
Using amq-protocol 2.3.4
Using excon 1.2.7
Using bunny 2.24.0
=> test_routing_key this is the data
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
published message: this is the data
"received"
"\"this is the data\""
{content_type: "application/json", delivery_mode: 2, priority: 0}
"test_routing_key"
closing AMQP connection
```

What RabbitMQ is logging

```
2025-06-03 15:03:50.991730+00:00 [info] <0.1460.0> Adding vhost 'test_b7c2fcb6' (description: '', tags: [])
2025-06-03 15:03:51.003222+00:00 [info] <0.1472.0> Making sure data directory '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC' for vhost 'test_b7c2fcb6' exists
2025-06-03 15:03:51.004161+00:00 [info] <0.1472.0> Setting segment_entry_count for vhost 'test_b7c2fcb6' with 0 queues to '2048'
2025-06-03 15:03:51.007425+00:00 [info] <0.1472.0> Starting message stores for vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.008739+00:00 [info] <0.1472.0> Started message store of type transient for vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.009123+00:00 [warning] <0.1485.0> Message store "1N8FGS4YSHO3CB5Y48KEP5YJC/msg_store_persistent": rebuilding indices from scratch
2025-06-03 15:03:51.009651+00:00 [info] <0.1472.0> Started message store of type persistent for vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.009723+00:00 [info] <0.1472.0> Recovering 0 queues of type rabbit_classic_queue took 4ms
2025-06-03 15:03:51.009758+00:00 [info] <0.1472.0> Recovering 0 queues of type rabbit_quorum_queue took 0ms
2025-06-03 15:03:51.009820+00:00 [info] <0.1472.0> Recovering 0 queues of type rabbit_stream_queue took 0ms
2025-06-03 15:03:51.011696+00:00 [info] <0.1460.0> Successfully set permissions for user 'guest' in virtual host 'test_b7c2fcb6' to '.*', '.*', '.*'
2025-06-03 15:03:51.014057+00:00 [info] <0.1516.0> accepting AMQP connection 192.168.65.1:54477 -> 172.17.0.2:5672
2025-06-03 15:03:51.015498+00:00 [info] <0.1516.0> connection 192.168.65.1:54477 -> 172.17.0.2:5672: user 'guest' authenticated and granted access to vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.023325+00:00 [info] <0.1516.0> closing AMQP connection (192.168.65.1:54477 -> 172.17.0.2:5672, vhost: 'test_b7c2fcb6', user: 'guest', duration: '9ms')
2025-06-03 15:03:51.024076+00:00 [info] <0.1545.0> Deleting vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.024117+00:00 [info] <0.1545.0> Clearing permissions in vhost 'test_b7c2fcb6' because it's being deleted
2025-06-03 15:03:51.025243+00:00 [info] <0.1545.0> Deleting queues in vhost 'test_b7c2fcb6' because it's being deleted
2025-06-03 15:03:51.027415+00:00 [info] <0.1545.0> Deleting exchanges in vhost 'test_b7c2fcb6' because it's being deleted
2025-06-03 15:03:51.028636+00:00 [info] <0.1545.0> Clearing policies and runtime parameters in vhost 'test_b7c2fcb6' because it's being deleted
2025-06-03 15:03:51.029261+00:00 [info] <0.1545.0> Stopping vhost supervisor <0.1471.0> for vhost 'test_b7c2fcb6'
2025-06-03 15:03:51.029267+00:00 [info] <0.1564.0> Closing all connections in vhost 'test_b7c2fcb6' because it's being deleted
2025-06-03 15:03:51.029291+00:00 [info] <0.1472.0> Virtual host 'test_b7c2fcb6' is stopping
2025-06-03 15:03:51.029338+00:00 [info] <0.1485.0> Stopping message store for directory '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC/msg_store_persistent'
2025-06-03 15:03:51.029325+00:00 [info] <0.1566.0> Closing all connections in vhost 'test_b7c2fcb6' on node 'rabbit@3623e0314fb1' because the vhost is stopping
2025-06-03 15:03:51.031127+00:00 [info] <0.1485.0> Message store for directory '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC/msg_store_persistent' is stopped
2025-06-03 15:03:51.031196+00:00 [info] <0.1481.0> Stopping message store for directory '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC/msg_store_transient'
2025-06-03 15:03:51.033083+00:00 [info] <0.1481.0> Message store for directory '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC/msg_store_transient' is stopped
2025-06-03 15:03:51.033274+00:00 [info] <0.1545.0> Deleting message store directory for vhost 'test_b7c2fcb6' at '/var/lib/rabbitmq/mnesia/rabbit@3623e0314fb1/msg_stores/vhosts/1N8FGS4YSHO3CB5Y48KEP5YJC'
```
