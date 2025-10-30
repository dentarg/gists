require "ractor/shim"
require "ractor-pool"

fib_worker = lambda do |index|
  first, second = 0, 1
  index.times { first, second = second, first + second }
  [index, first]
end

size = 2
count = ARGV.first.to_i
count = count.zero? ? 25 : count
results = []
pool = RactorPool.new(size:, worker: fib_worker) { |result| results << result }

puts "Started RactorPool with size=#{size}"

start = Process.clock_gettime(Process::CLOCK_MONOTONIC)

count.times { |index| pool << index }
pool.shutdown

puts "Took #{Process.clock_gettime(Process::CLOCK_MONOTONIC) - start} seconds"

# results.sort_by! { |index, _value| index }
# results.each { |index, value| puts "fib(#{index}) = #{value}" }
