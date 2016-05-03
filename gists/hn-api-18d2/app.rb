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

# getting item 11531197... (2016-04-20 01:08:13 +0200)
# /Users/dentarg/.rubies/ruby-2.3.0/lib/ruby/2.3.0/json/common.rb:156:in `parse': 822: unexpected token at '' (JSON::ParserError)
#   from /Users/dentarg/.rubies/ruby-2.3.0/lib/ruby/2.3.0/json/common.rb:156:in `parse'
#   from /Users/dentarg/.gem/ruby/2.3.0/gems/firebase-0.2.6/lib/firebase/response.rb:10:in `body'
#   from app.rb:11:in `block in <main>'
#   from app.rb:10:in `loop'
#   from app.rb:10:in `<main>'
