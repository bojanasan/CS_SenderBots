require 'sqlite3'


module CraigslistMonitor

  class Listing
    attr_reader :url, :title, :email
    def initialize(opts = {})
      @url   = opts.fetch(:url)   { raise Error }
      @title = opts.fetch(:title) { raise Error }
      @email = opts.fetch(:email) { raise Error }
    end

    def store_to_db
      @db = SQLite3::Database.new "./craigslist_monitor.db"
      query_result = @db.execute("SELECT COUNT(*) FROM listings WHERE email = ?", @email)
      if query_result.first.first == 0
        time = Time.now
        @db.execute("INSERT INTO listings (url, title, email, created_at, updated_at) VALUES (?, ?, ?, '#{time}', '#{time}')", @url, @title, @email)
      end
    end

  end

end
