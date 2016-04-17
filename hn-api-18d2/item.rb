class Item
  attr_reader :body

  def initialize(body)
    @body = body
  end

  def id
    body["id"]
  end

  def kids
    body["kids"]
  end

  def kids_count
    Array(body["kids"]).count
  end

  def score
    body["score"]
  end

  def time
    Time.at(body["time"].to_i)
  end

  def title
    body["title"]
  end

  def type
    body["type"]
  end

  def url
    body["url"]
  end

  def story?
    type == "story"
  end
end
