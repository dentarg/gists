require "open-uri"
require "nokogiri"
require "json"
require "time"

html = open("http://klubbdinmamma.com/events/") ; nil
doc = Nokogiri::HTML(html) ; nil

events = doc.css(".row ul li").map do |element|
  date, name = element.text.split(" - ")
  datetime = Time.parse(date).to_datetime
  year     = datetime.year

  {
    year: year,
    date: datetime,
    name: name,
  }
end ; nil

puts JSON.pretty_generate(events)
