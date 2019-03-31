# frozen_string_literal: true

require "capybara/rspec"
require "capybara/apparition"
require "billy/capybara/rspec"
require "logger"
require "nokogiri"
require "pry-byebug"
require "terminal-table"
require "bigdecimal"

RSpec.configure do |config|
  config.include Capybara::DSL
end

Billy.configure do |config|
  config.cache = true
  config.persist_cache = true
  config.record_stub_requests = true
  config.cache_path = "billy_cache/"
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

URL   = "http://www.barsebackresort.se/git/competition/?guid=1765905&fwid=0"
TABLE = "sgf-git-templates-competition-info-entrylist-content"

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

  def initialize(player_rows)
    @players = player_rows.map do |player_row|
      name = player_row[1].split(" - ").last
      club = player_row[2]
      hcp  = BigDecimal(player_row[3].sub(",", "."))

      Player.new(self, name, club, hcp)
    end

    @name = player_rows.first[1].split(" - ").first
    @hcp  = @players.map(&:hcp).inject(:+)
  end

  def player_list
    @players.map(&:to_s).join("\n")
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
    players = rows.map { |row| row.css('td').map(&:text) }.reject(&:empty?)
    teams   = []

    players.each_slice(2) do |player_rows|
      teams << Team.new(player_rows)
    end

    headers = ["", "Hcp", "Lag", "Spelare"]
    tt_rows = []
    teams.sort_by(&:hcp).each_with_index do |team, idx|
      tt_rows << :separator unless idx == 0
      tt_rows << [idx + 1, *team.to_a]
    end

    puts Terminal::Table.new(headings: headers, rows: tt_rows)
  end
end
