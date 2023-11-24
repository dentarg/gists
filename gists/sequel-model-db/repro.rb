require "logger"
require "sequel"
require "tmpdir"

def create_and_migrate(database_name:, table_name:)
  system "createdb #{database_name}"

  Dir.mktmpdir do |migrations_dir|
    migration = <<~SQL
      Sequel.migration do
        change do
          create_table :#{table_name}
        end
      end
    SQL
    File.write(File.join(migrations_dir, "1_#{table_name}.rb"), migration)
    url = "postgres://localhost/#{database_name}"
    puts ["", "Migrating #{url}", ""]
    Sequel.extension(:migration)
    Sequel.connect(url) do |db|
      db.loggers << ::Logger.new($stdout)
      Sequel::Migrator.run(db, migrations_dir)
    end
    database = Sequel.connect(url)
    yield
    database.disconnect
    Sequel::DATABASES.each(&:disconnect)

    puts ["", "inside create_and_migrate, after disconnect", "Sequel::Model.db=#{Sequel::Model.db.inspect}", ""]
  end
end

prefix = "sequel_database"

table_name = "cars"
database_name = "#{prefix}_#{table_name}"
create_and_migrate(database_name:, table_name:) do
  class Car < Sequel::Model; end
  puts Car.db.inspect
end

table_name = "bikes"
database_name = "#{prefix}_#{table_name}"
create_and_migrate(database_name:, table_name:) do
  puts ["", "before defining Bike", "Sequel::Model.db=#{Sequel::Model.db.inspect}", ""]
  class Bike < Sequel::Model; end
  puts Bike.db.inspect
end

# run like this
# dropdb sequel_database_cars ; dropdb sequel_database_bikes ; ruby repro.rb
