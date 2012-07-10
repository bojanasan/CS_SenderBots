require 'sqlite3'


module CraigslistMonitor

  class Listing
    def initialize(opts = {})
      @url   = opts.fetch(:url)   { raise Error }
      @title = opts.fetch(:title) { raise Error }
      @email = opts.fetch(:email) { raise Error }
    end

    def store_to_db
      @db = SQLite3::Database.new "./craigslist_monitor.db"
      query_result = @db.execute("SELECT * FROM listings WHERE email='#{@email}'")
      if query_result == [] || query_result == [[]]
        @db.execute("INSERT INTO listings (url, title, email, created_at, updated_at) VALUES ('#{@url}','#{@title}','#{@email}','#{Time.now}', '#{Time.now}')")
      end
    end

  end

end