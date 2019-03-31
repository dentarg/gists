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

URLS = {
  "2018" => {
    url: "http://www.varbergsgk.se/git/competition/?guid=1358688&fwid=0",
    table: "sgf-git-templates-competition-info-startlist-content",
  },

  "2019" => {
    url:   "http://www.barsebackresort.se/git/competition/?guid=1765905&fwid=0",
    table: "sgf-git-templates-competition-info-entrylist-content",
  }
}

YEAR  = ENV.fetch("YEAR", "2019")
URL   = URLS[YEAR][:url]
TABLE = URLS[YEAR][:table]
CACHE = FileUtils.mkdir_p(File.join(__dir__, "billy_cache", YEAR, "/")).first

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

Player = Struct.new(:team, :name, :club, :hcp) do
  def first_name
    name.split(" ").first
  end

  def to_s
    sprintf "% 5.1f %s (%s)", hcp.to_f, first_name, club
  end
end

class Team
  attr_reader :name, :hcp

  def initialize(team_players)
    @players = team_players.map do |hsh|
      name = hsh.fetch("Namn").split(" - ").last
      club = hsh.fetch("Klubb")
      hcp  = BigDecimal(hsh.fetch("HCP").sub(",", "."))

      Player.new(self, name, club, hcp)
    end

    @name = team_players.first.fetch("Namn").split(" - ").first
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

    doc     = Nokogiri::HTML(page.body)
    table   = doc.css(".#{TABLE}").first
    rows    = table.css("tr")
    columns = rows.flat_map { |row| row.css('th').map(&:text) }
    players = rows
                .map { |row| row.css('td').map(&:text) }
                .reject(&:empty?)
                .map { |row| columns.zip(row).to_h }

    teams = []
    players.each_slice(2) do |team_players|
      teams << Team.new(team_players)
    end

    headers = ["", "Hcp", "Lag", "Spelare"]
    tt_rows = []
    teams.uniq.sort_by(&:hcp).each_with_index do |team, idx|
      tt_rows << :separator unless idx == 0
      tt_rows << [idx + 1, *team.to_a]
    end

    puts Terminal::Table.new(headings: headers, rows: tt_rows)
  end
end
