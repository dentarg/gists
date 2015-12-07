require "itunes_parser"

parser = ItunesParser.new( open("/Users/dentarg/Downloads/CD.xml") )

parser.tracks.each do |track|
  time = track["Total Time"]
  time = time.to_i/60
  puts sprintf("%s - %s (%s)", track["Name"], track["Artist"], time)
end
