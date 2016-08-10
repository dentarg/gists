require "open-uri"
require "nokogiri"
require "yaml/store"
require "time"

html = open("http://klubbdinmamma.com/events/") ; nil
doc = Nokogiri::HTML(html) ; nil

events = doc.css(".row ul li").map do |element|
  date, name = element.text.split(" - ")
  datetime = Time.parse(date).to_datetime
  year     = datetime.year

  {
    "date" => datetime.to_s,
    "name" => name,
  }
end ; nil

years = events.map { |event| event[:year] }.uniq

years.each do |year|
  store = YAML::Store.new("events_#{year}.yml")

  store.transaction do
    store["events"] = events.select { |event| event[:year] == year }
  end
end

