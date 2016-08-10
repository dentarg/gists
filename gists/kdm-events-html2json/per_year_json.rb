require "open-uri"
require "nokogiri"
require "json"
require "time"

html = open("http://klubbdinmamma.com/events/") ; nil
doc = Nokogiri::HTML(html) ; nil

events = doc.css(".row ul li").map do |element|
  date, name = element.text.split(" - ")

  {
    "date" => date,
    "name" => name,
  }
end ; nil

years = events.map { |event| event["date"].split("-").first }.uniq

years.each do |year|
  selected_events = events.select { |event| event["date"].split("-").first == year }
  json = JSON.pretty_generate(selected_events)

  File.open("events_#{year}.json", "w") { |file| file.write(json) }
end

