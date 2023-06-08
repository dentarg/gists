# frozen_string_literal: true

require "capybara/rspec"
require "capybara/apparition"
require "billy/capybara/rspec"
require "logger"
require "nokogiri"
require "pry-byebug"
require "terminal-table"
require "bigdecimal"
require "fileutils"
require "tmpdir"
require "json"

URLS = {
  "2018" => {
    url: "http://www.varbergsgk.se/git/competition/?guid=1358688&fwid=0",
    table: "sgf-git-templates-competition-info-startlist-content",
  },

  "2019" => {
    url:   "http://www.barsebackresort.se/git/competition/?guid=1765905&fwid=0",
    table: "sgf-git-templates-competition-info-entrylist-content",
  },

  "2023" => {
    url:   "https://www.karlshamnsgk.com/git/competition/?guid=3766681",
    table: "sgf-git-templates-competition-info-entrylist-content",
  }
}

YEAR  = ENV.fetch("YEAR", "2023")
URL   = URLS[YEAR][:url]
TABLE = URLS[YEAR][:table]
root  = ENV.fetch("TMP", false) ? Dir.mktmpdir("farson-2019") : __dir__
CACHE = FileUtils.mkdir_p(File.join(root, "billy_cache", YEAR, "/")).first

RSpec.configure do |config|
  config.include Capybara::DSL
end

Billy.configure do |config|
  config.cache = true
  config.persist_cache = true
  config.record_stub_requests = true
  config.cache_path = CACHE
  config.logger = ENV["LOG"] ? Logger.new(STDOUT) : Logger.new("/dev/null")
end

Capybara.register_driver :apparition_with_puffing_billy do |app|
  options = {
    window_size: [1280, 1024],
    headless: true,
    js_errors: false,
    ignore_https_errors: true,
    browser_options: {
      "ignore-certificate-errors" => nil
    }
  }
  Capybara::Apparition::Driver.new(app, options).tap do |driver|
    driver.set_proxy(Billy.proxy.host, Billy.proxy.port)
  end
end

Capybara.default_driver = :apparition_with_puffing_billy

class Player
  attr_reader :nr, :team_name, :full_name, :last_name, :club, :hcp

  def initialize(player_hash)
    # puts "player_hash=#{player_hash.inspect}"
    @player_hash = player_hash
    @nr          = player_hash.fetch("Nr.")
    @team_name   = player_hash.fetch("Namn").split(" - ").first
    @full_name   = player_hash.fetch("Namn").split(" - ").last
    @last_name   = full_name.split(" ", 2).last
    @club        = player_hash.fetch("Klubb")
    @hcp         = BigDecimal(player_hash.fetch("HCP").sub(",", "."))
  end

  def to_s
    format("% 5.1f - %s. %s (%s)", hcp.to_f, nr, full_name, club)
  end

  def inspect
    format %w[
      #<Player:0x%x
      @nr=%s
      @team_name="%s"
      @full_name="%s"
      @last_name="%s"
      @club="%s"
      @hcp=%g>].join(" "),
      object_id,
      nr,
      team_name,
      full_name,
      last_name,
      club,
      hcp.to_f
  end
end

class Team
  attr_reader :name, :hcp

  def initialize(player1, player2)
    @players = [player1, player2]
    @name = player1.team_name
    @hcp  = @players.map(&:hcp).inject(:+)
  end

  def player_list
    @players.map(&:to_s).sort.join("\n")
  end

  def eql?(other)
    return false unless other.is_a?(self.class)

    self.hash == other.hash
  end

  def hash
    to_a.hash
  end

  def to_a
    [@hcp.to_f, @name, player_list]
  end
end

RSpec.describe do
  it do
    proxy.stub(URL)
    visit(URL)

    anon_players = []

    doc     = Nokogiri::HTML(page.body)
    table   = doc.css(".#{TABLE}").first
    rows    = table.css("tr")
    columns = rows.flat_map { |row| row.css('th').map(&:text) }
    player_hashes = rows
                .map { |row| row.css('td').map(&:text) }
                .reject(&:empty?)
                .map { |row| columns.zip(row).to_h }
    players = player_hashes.map do |player_hash|
      if player_hash.fetch("Namn") == "Anonym"
        anon_players << player_hash
        next
      end
      Player.new(player_hash)
    end.compact

    teams = []

    players.group_by { |p| p.team_name }.each do |_, players|
      if players.size == 2
        teams << Team.new(*players)
      end

      if players.size > 2
        players.each_slice(2) { |p1, p2| teams << Team.new(p1, p2) }
      end
    end

    # binding.pry

    headers = ["", "Hcp", "Lag", "Spelare"]
    tt_rows = []
    teams.uniq.sort_by(&:hcp).each_with_index do |team, index|
      tt_rows << :separator unless index == 0
      tt_rows << [index + 1, *team.to_a]
    end

    puts Terminal::Table.new(headings: headers, rows: tt_rows)

    puts "Total of 'Anonym' players: #{anon_players.count}"
    puts JSON.pretty_generate(anon_players)
  end
end
