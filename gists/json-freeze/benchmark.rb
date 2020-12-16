require "benchmark/memory"

# https://api.github.com/meta
JSON_STR = File.read(File.expand_path("~/Downloads/meta"))

def normal_parse
  1000.times do
    JSON.parse(JSON_STR)
  end
end

def freeze_parse
  1000.times do
    JSON.parse(JSON_STR, freeze: true)
  end
end

Benchmark.memory do |x|
  x.report("normal parse") { normal_parse }
  x.report("freeze parse") { freeze_parse }

  x.compare!
end
