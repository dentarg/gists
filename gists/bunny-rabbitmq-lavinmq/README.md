# more `puts` debug

tl;dr

```ruby
# RabbitMQ
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class=AMQ::Protocol::Basic::Deliver
1 run_once frame.method_class=AMQ::Protocol::Basic::Ack

# LavinMQ
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class=AMQ::Protocol::Basic::Ack
1 run_once frame.method_class=AMQ::Protocol::Basic::Deliver
```

full logs:


```ruby
# RabbitMQ
$ AMQP_MGMT_PORT=15673 AMQP_PORT=5673 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012991edd8 @payload="\u0000\u0014\u0000\v\u0000\u0000\u0000\u0000", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::OpenOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012991d280 @payload="\u0000<\u0000\v", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::QosOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012991bd18 @payload="\u0000U\u0000\v", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012991a5f8 @payload="\u00002\u0000\v\u000Ftest_queue_name\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::DeclareOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x0000000129919518 @payload="\u00002\u0000\u0015", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::BindOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x0000000129918848 @payload="\u00002\u0000\u0015", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::BindOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001299171c8 @payload="\u0000<\u0000\u0015 bunny-1748968762000-820136351586", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::ConsumeOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x0000000129915e68 @payload="\u0000\u0014\u0000\v\u0000\u0000\u0000\u0000", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::OpenOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001299153c8 @payload="\u0000<\u0000\v", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::QosOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001299149a0 @payload="\u0000U\u0000\v", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class.has_content?=false
0 run_once
=> test_routing_key this is the data
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x0000000129912c18 @payload="\u0000<\u0000< bunny-1748968762000-820136351586\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0001\u0000\tamq.topic\u0010test_routing_key", @channel=1>
1 run_once frame.final?=false
1 run_once frame.method_class=AMQ::Protocol::Basic::Deliver
1 run_once frame.method_class.has_content?=true
0 handle_frameset
0 run_once
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x0000000129910580 @payload="\u0000<\u0000P\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0001\u0000", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::Ack
1 run_once frame.method_class.has_content?=false
0 run_once
published message: this is the data
"received"
"\"this is the data\""
{content_type: "application/json", delivery_mode: 2, priority: 0}
"test_routing_key"
closing AMQP connection
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001298deeb8 @payload="\u0000\u0014\u0000)", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001298ddf18 @payload="\u0000\u0014\u0000)", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001298dd388 @payload="\u0000\n\u00003", @channel=0>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Connection::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
```

```ruby
# LavinMQ
$ AMQP_MGMT_PORT=15674 AMQP_PORT=5674 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290cfd30 @payload="\u0000\u0014\u0000\v\u0000\u0000\u0000\u0000", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::OpenOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290ce1d8 @payload="\u0000<\u0000\v", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::QosOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290ccbf8 @payload="\u0000U\u0000\v", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290cb500 @payload="\u00002\u0000\v\u000Ftest_queue_name\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::DeclareOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290ca3f8 @payload="\u00002\u0000\u0015", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::BindOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c9778 @payload="\u00002\u0000\u0015", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Queue::BindOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c80a8 @payload="\u0000<\u0000\u0015\u001Fbunny-1748968769000-79427470050", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::ConsumeOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c6d70 @payload="\u0000\u0014\u0000\v\u0000\u0000\u0000\u0000", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::OpenOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c6348 @payload="\u0000<\u0000\v", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::QosOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c5880 @payload="\u0000U\u0000\v", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Confirm::SelectOk
1 run_once frame.method_class.has_content?=false
0 run_once
=> test_routing_key this is the data
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c3af8 @payload="\u0000<\u0000P\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0001\u0000", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Basic::Ack
1 run_once frame.method_class.has_content?=false
0 run_once
published message: this is the data
"received"
nil
nil
nil
closing AMQP connection
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x00000001290c2450 @payload="\u0000<\u0000<\u001Fbunny-1748968769000-79427470050\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0001\u0000\tamq.topic\u0010test_routing_key", @channel=1>
1 run_once frame.final?=false
1 run_once frame.method_class=AMQ::Protocol::Basic::Deliver
1 run_once frame.method_class.has_content?=true
0 handle_frameset
0 run_once
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
/Users/dentarg/src/bunny/lib/bunny/session.rb:1128:in 'Bunny::Session#send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x00000001290c02e0 @payload="\x00<\x00P\x00\x00\x00\x00\x00\x00\x00\x01\x00", @channel=1>, method class is AMQ::Protocol::Basic::Ack (Bunny::ConnectionClosedError)
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:842:in 'block in Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:2122:in 'Bunny::Channel#guarding_against_stale_delivery_tags'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:840:in 'Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:554:in 'Bunny::Channel#ack'
  from pubsub.rb:89:in 'block in Amqp::Group#subscribe'
  from /Users/dentarg/src/bunny/lib/bunny/consumer.rb:56:in 'Bunny::Consumer#call'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:1844:in 'block in Bunny::Channel#handle_frameset'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:108:in 'block (2 levels) in Bunny::ConsumerWorkPool#run_loop'
  from <internal:kernel>:168:in 'Kernel#loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:103:in 'block in Bunny::ConsumerWorkPool#run_loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Kernel#catch'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Bunny::ConsumerWorkPool#run_loop'
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012908f960 @payload="\u0000\u0014\u0000)", @channel=1>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012908e998 @payload="\u0000\u0014\u0000)", @channel=2>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Channel::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
1 run_once frame=#<AMQ::Protocol::MethodFrame:0x000000012908de08 @payload="\u0000\n\u00003", @channel=0>
1 run_once frame.final?=true
1 run_once frame.method_class=AMQ::Protocol::Connection::CloseOk
1 run_once frame.method_class.has_content?=false
0 run_once
```


# bunny debug logs

## LavinMQ

```shell
$ AMQP_MGMT_PORT=15674 AMQP_PORT=5674 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
D, [2025-06-03T18:11:28.993874 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Sent protocol preamble
D, [2025-06-03T18:11:28.994573 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Sent connection.start-ok
D, [2025-06-03T18:11:28.994926 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Heartbeat interval negotiation: client = server, server = 300, result = 300
I, [2025-06-03T18:11:28.994933 #84973]  INFO -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Heartbeat interval used (in seconds): 300
D, [2025-06-03T18:11:28.994940 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Will use socket read timeout of 660 seconds
D, [2025-06-03T18:11:28.994957 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Initializing channel ID allocator with channel_max = 2048
D, [2025-06-03T18:11:28.994986 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Sent connection.tune-ok with heartbeat interval = 300, frame_max = 131072, channel_max = 2048
D, [2025-06-03T18:11:28.994999 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Sent connection.open with vhost = test_b8c9d858
D, [2025-06-03T18:11:28.995274 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Initializing heartbeat sender...
D, [2025-06-03T18:11:28.995348 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Allocated channel id: 1
D, [2025-06-03T18:11:28.995719 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Channel::OpenOk:0x0000000126664118 @channel_id="">
D, [2025-06-03T18:11:28.996027 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Basic::QosOk:0x00000001266625c0>
D, [2025-06-03T18:11:28.996040 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Basic::QosOk:0x00000001266625c0>
D, [2025-06-03T18:11:28.996340 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Confirm::SelectOk:0x00000001266609c8>
D, [2025-06-03T18:11:28.996346 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Confirm::SelectOk:0x00000001266609c8>
D, [2025-06-03T18:11:29.000249 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::DeclareOk:0x0000000126229d50 @queue="test_queue_name", @message_count=0, @consumer_count=0>
D, [2025-06-03T18:11:29.000258 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::DeclareOk:0x0000000126229d50 @queue="test_queue_name", @message_count=0, @consumer_count=0>
D, [2025-06-03T18:11:29.001572 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::BindOk:0x0000000126228e00>
D, [2025-06-03T18:11:29.001578 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::BindOk:0x0000000126228e00>
D, [2025-06-03T18:11:29.002605 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::BindOk:0x0000000126102878>
D, [2025-06-03T18:11:29.002613 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::BindOk:0x0000000126102878>
D, [2025-06-03T18:11:29.003118 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Basic::ConsumeOk:0x0000000125088d80 @consumer_tag="bunny-1748967089000-609909501470">
D, [2025-06-03T18:11:29.003127 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Basic::ConsumeOk:0x0000000125088d80 @consumer_tag="bunny-1748967089000-609909501470">
D, [2025-06-03T18:11:29.003156 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Allocated channel id: 2
D, [2025-06-03T18:11:29.003507 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 2: #<AMQ::Protocol::Channel::OpenOk:0x00000001248ca508 @channel_id="">
D, [2025-06-03T18:11:29.003690 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 2: #<AMQ::Protocol::Basic::QosOk:0x00000001247898d8>
D, [2025-06-03T18:11:29.003697 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Basic::QosOk:0x00000001247898d8>
D, [2025-06-03T18:11:29.003871 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 2: #<AMQ::Protocol::Confirm::SelectOk:0x0000000124788a50>
D, [2025-06-03T18:11:29.003878 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Confirm::SelectOk:0x0000000124788a50>
=> test_routing_key this is the data
D, [2025-06-03T18:11:29.004171 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 2: #<AMQ::Protocol::Basic::Ack:0x00000001247856e8 @delivery_tag=1, @multiple=false>
D, [2025-06-03T18:11:29.004180 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Basic::Ack:0x00000001247856e8 @delivery_tag=1, @multiple=false>
published message: this is the data
"received"
nil
nil
nil
closing AMQP connection
D, [2025-06-03T18:11:29.004222 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Transport is still open...
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
/Users/dentarg/src/bunny/lib/bunny/session.rb:1128:in 'Bunny::Session#send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x0000000120888a58 @payload="\x00<\x00P\x00\x00\x00\x00\x00\x00\x00\x01\x00", @channel=1>, method class is AMQ::Protocol::Basic::Ack (Bunny::ConnectionClosedError)
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:842:in 'block in Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:2121:in 'Bunny::Channel#guarding_against_stale_delivery_tags'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:840:in 'Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:554:in 'Bunny::Channel#ack'
  from pubsub.rb:87:in 'block in Amqp::Group#subscribe'
  from /Users/dentarg/src/bunny/lib/bunny/consumer.rb:56:in 'Bunny::Consumer#call'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:1843:in 'block in Bunny::Channel#handle_frameset'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:108:in 'block (2 levels) in Bunny::ConsumerWorkPool#run_loop'
  from <internal:kernel>:168:in 'Kernel#loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:103:in 'block in Bunny::ConsumerWorkPool#run_loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Kernel#catch'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Bunny::ConsumerWorkPool#run_loop'
D, [2025-06-03T18:11:29.004920 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 1: #<AMQ::Protocol::Channel::CloseOk:0x0000000120886050>
D, [2025-06-03T18:11:29.005230 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 2: #<AMQ::Protocol::Channel::CloseOk:0x0000000120882b08>
D, [2025-06-03T18:11:29.005257 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Will close all channels....
D, [2025-06-03T18:11:29.005264 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Transport is still open
D, [2025-06-03T18:11:29.005282 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Waiting for a connection.close-ok...
D, [2025-06-03T18:11:29.005567 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Session#handle_frame on 0: #<AMQ::Protocol::Connection::CloseOk:0x000000012704fc90>
D, [2025-06-03T18:11:29.005655 #84973] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5674, vhost=test_b8c9d858, addresses=[localhost:5674]>: Connection is closed
```

## RabbitMQ

```shell
$ AMQP_MGMT_PORT=15673 AMQP_PORT=5673 ruby pubsub.rb
Fetching gem metadata from https://rubygems.org/..
Resolving dependencies...
D, [2025-06-03T18:11:33.370989 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Sent protocol preamble
D, [2025-06-03T18:11:33.372227 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Sent connection.start-ok
D, [2025-06-03T18:11:33.372507 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Heartbeat interval negotiation: client = server, server = 60, result = 60
I, [2025-06-03T18:11:33.372515 #85045]  INFO -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Heartbeat interval used (in seconds): 60
D, [2025-06-03T18:11:33.372521 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Will use socket read timeout of 132 seconds
D, [2025-06-03T18:11:33.372525 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Initializing channel ID allocator with channel_max = 2047
D, [2025-06-03T18:11:33.372549 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Sent connection.tune-ok with heartbeat interval = 60, frame_max = 131072, channel_max = 2047
D, [2025-06-03T18:11:33.372562 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Sent connection.open with vhost = test_09a0aaaa
D, [2025-06-03T18:11:33.372754 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Initializing heartbeat sender...
D, [2025-06-03T18:11:33.372833 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Allocated channel id: 1
D, [2025-06-03T18:11:33.373241 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Channel::OpenOk:0x000000014897e0c0 @channel_id="">
D, [2025-06-03T18:11:33.373449 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Basic::QosOk:0x000000014897c7e8>
D, [2025-06-03T18:11:33.373460 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Basic::QosOk:0x000000014897c7e8>
D, [2025-06-03T18:11:33.373639 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Confirm::SelectOk:0x000000014897b1b8>
D, [2025-06-03T18:11:33.373645 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Confirm::SelectOk:0x000000014897b1b8>
D, [2025-06-03T18:11:33.375175 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::DeclareOk:0x0000000148979868 @queue="test_queue_name", @message_count=0, @consumer_count=0>
D, [2025-06-03T18:11:33.375188 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::DeclareOk:0x0000000148979868 @queue="test_queue_name", @message_count=0, @consumer_count=0>
D, [2025-06-03T18:11:33.376705 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::BindOk:0x00000001489787d8>
D, [2025-06-03T18:11:33.376726 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::BindOk:0x00000001489787d8>
D, [2025-06-03T18:11:33.377993 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Queue::BindOk:0x0000000148977b30>
D, [2025-06-03T18:11:33.378009 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Queue::BindOk:0x0000000148977b30>
D, [2025-06-03T18:11:33.378374 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Basic::ConsumeOk:0x00000001489762f8 @consumer_tag="bunny-1748967093000-771813566845">
D, [2025-06-03T18:11:33.378381 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 1: #<AMQ::Protocol::Basic::ConsumeOk:0x00000001489762f8 @consumer_tag="bunny-1748967093000-771813566845">
D, [2025-06-03T18:11:33.378408 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Allocated channel id: 2
D, [2025-06-03T18:11:33.378737 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 2: #<AMQ::Protocol::Channel::OpenOk:0x0000000148974f20 @channel_id="">
D, [2025-06-03T18:11:33.378901 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 2: #<AMQ::Protocol::Basic::QosOk:0x00000001489744f8>
D, [2025-06-03T18:11:33.378907 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Basic::QosOk:0x00000001489744f8>
D, [2025-06-03T18:11:33.379059 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 2: #<AMQ::Protocol::Confirm::SelectOk:0x0000000148973a80>
D, [2025-06-03T18:11:33.379065 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Confirm::SelectOk:0x0000000148973a80>
=> test_routing_key this is the data
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
D, [2025-06-03T18:11:33.379752 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 2: #<AMQ::Protocol::Basic::Ack:0x000000014893f320 @delivery_tag=1, @multiple=false>
D, [2025-06-03T18:11:33.379763 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Channel#handle_frame on channel 2: #<AMQ::Protocol::Basic::Ack:0x000000014893f320 @delivery_tag=1, @multiple=false>
published message: this is the data
"received"
"\"this is the data\""
{content_type: "application/json", delivery_mode: 2, priority: 0}
"test_routing_key"
closing AMQP connection
D, [2025-06-03T18:11:33.379819 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Transport is still open...
D, [2025-06-03T18:11:33.380054 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 1: #<AMQ::Protocol::Channel::CloseOk:0x000000014893de58>
D, [2025-06-03T18:11:33.380301 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 2: #<AMQ::Protocol::Channel::CloseOk:0x000000014893cf58>
D, [2025-06-03T18:11:33.380320 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Will close all channels....
D, [2025-06-03T18:11:33.380335 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Transport is still open
D, [2025-06-03T18:11:33.380351 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Waiting for a connection.close-ok...
D, [2025-06-03T18:11:33.380533 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Session#handle_frame on 0: #<AMQ::Protocol::Connection::CloseOk:0x000000014893c1c0>
D, [2025-06-03T18:11:33.380589 #85045] DEBUG -- #<Bunny::Session:0x580 guest@localhost:5673, vhost=test_09a0aaaa, addresses=[localhost:5673]>: Connection is closed
```


# `puts` debugging

Using https://github.com/ruby-amqp/bunny/compare/main...dentarg:bunny:lavinmq-debug we can see that there is a difference with running the `run_once` method https://github.com/ruby-amqp/bunny/blob/2.23.0/lib/bunny/reader_loop.rb#L73-L94

logs zoomed in

```shell
# LavinMQ
=> test_routing_key this is the data
1 run_once
5 run_once
0 run_once
published message: this is the data
"received"
nil

# RabbitMQ
=> test_routing_key this is the data
1 run_once
2 run_once
3 run_once
4 run_once
0 run_once
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
1 run_once
5 run_once
0 run_once
published message: this is the data
"received"
"\"this is the data\""
```

logs zoomed out


```shell
# LavinMQ
6 basic_consume_with @last_basic_consume_ok=#<AMQ::Protocol::Basic::ConsumeOk:0x0000000150e14a50 @consumer_tag="bunny-1748965775000-159566659896">
1 run_once
5 run_once
0 run_once
0 wait_on_continuations
1 wait_on_continuations
2 wait_on_continuations
1 run_once
5 run_once
0 run_once
0 wait_on_continuations
1 wait_on_continuations
2 wait_on_continuations
1 run_once
5 run_once
0 run_once
=> test_routing_key this is the data
1 run_once
5 run_once
0 run_once
published message: this is the data
"received"
nil
nil
nil
closing AMQP connection
1 run_once
2 run_once
3 run_once
4 run_once
0 run_once
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
/Users/dentarg/src/bunny/lib/bunny/session.rb:1128:in 'Bunny::Session#send_frame': Trying to send frame through a closed connection. Frame is #<AMQ::Protocol::MethodFrame:0x0000000150e3e4b8 @payload="\x00<\x00P\x00\x00\x00\x00\x00\x00\x00\x01\x00", @channel=1>, method class is AMQ::Protocol::Basic::Ack (Bunny::ConnectionClosedError)
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:842:in 'block in Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:2133:in 'Bunny::Channel#guarding_against_stale_delivery_tags'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:840:in 'Bunny::Channel#basic_ack'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:554:in 'Bunny::Channel#ack'
  from pubsub.rb:87:in 'block in Amqp::Group#subscribe'
  from /Users/dentarg/src/bunny/lib/bunny/consumer.rb:56:in 'Bunny::Consumer#call'
  from /Users/dentarg/src/bunny/lib/bunny/channel.rb:1851:in 'block in Bunny::Channel#handle_frameset'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:108:in 'block (2 levels) in Bunny::ConsumerWorkPool#run_loop'
  from <internal:kernel>:168:in 'Kernel#loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:103:in 'block in Bunny::ConsumerWorkPool#run_loop'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Kernel#catch'
  from /Users/dentarg/src/bunny/lib/bunny/consumer_work_pool.rb:102:in 'Bunny::ConsumerWorkPool#run_loop'
1 run_once
5 run_once
0 run_once
1 run_once
5 run_once
0 run_once
1 run_once
5 run_once
0 run_once
```

```shell
# RabbitMQ
6 basic_consume_with @last_basic_consume_ok=#<AMQ::Protocol::Basic::ConsumeOk:0x000000013a0b7170 @consumer_tag="bunny-1748965752000-184280851432">
1 run_once
5 run_once
0 run_once
0 wait_on_continuations
1 wait_on_continuations
2 wait_on_continuations
1 run_once
5 run_once
0 run_once
0 wait_on_continuations
1 wait_on_continuations
2 wait_on_continuations
1 run_once
5 run_once
0 run_once
=> test_routing_key this is the data
1 run_once
2 run_once
3 run_once
4 run_once
0 run_once
<= test_routing_key test_queue_name "this is the data"
subscribe data=String
subscribe data="\"this is the data\""
1 run_once
5 run_once
0 run_once
published message: this is the data
"received"
"\"this is the data\""
{content_type: "application/json", delivery_mode: 2, priority: 0}
"test_routing_key"
closing AMQP connection
1 run_once
5 run_once
0 run_once
1 run_once
5 run_once
0 run_once
1 run_once
5 run_once
0 run_once
```


---

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
