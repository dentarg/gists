require "concurrent"

fib_worker = lambda do |index|
  first, second = 0, 1
  index.times { first, second = second, first + second }
  [index, first]
end

size = 2
count = ARGV.first.to_i
count = count.zero? ? 25 : count
futures = []
results = []
pool = Concurrent::FixedThreadPool.new(size) # threads

puts "Started FixedThreadPool with size=#{size}"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

count.times do |index|
  future = Concurrent::Future.execute(executor: pool) do
    fib_worker.call(index)
  end

  futures << future
end
futures.each { |future| results << future.value }
pool.shutdown

puts "Took #{Process.clock_gettime(Process::CLOCK_MONOTONIC) - start} seconds"

# results.sort_by! { |index, _value| index }
# results.each { |index, value| puts "fib(#{index}) = #{value}" }
