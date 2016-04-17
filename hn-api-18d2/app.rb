require "firebase"

require_relative "item"

base_uri = "https://hacker-news.firebaseio.com/"
firebase = Firebase::Client.new(base_uri)

seconds = 1
maxid   = 0

loop do
  updates     = firebase.get("v0/updates")&.body["items"]
  new_updates = updates.select { |item| item > maxid }
  maxid       = updates.max

  new_updates.each do |id|
    print "getting item #{id}..."

    body = firebase.get("v0/item/#{id}")&.body
    item = Item.new(body)

    if item.story?
      puts
      puts [item.kids_count, item.score, item.time, item.title, item.url].join(" ")
    else
      puts " (#{item.time})"
    end
  end

  if new_updates.empty?
    sleep seconds
  end
end
