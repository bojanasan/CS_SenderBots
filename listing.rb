require 'sqlite3'
require './mailgun.rb'

module CraigslistMonitor

  class Listing
    attr_reader :url, :title, :email
    def initialize(opts = {})
      @url   = opts.fetch(:url)   { raise Error }
      @title = opts.fetch(:title) { raise Error }
      @email = opts.fetch(:email) { raise Error }
      @db = SQLite3::Database.new "./craigslist_monitor.db"
    end

    def store_to_db
      query_result = @db.execute("SELECT COUNT(*) FROM listings WHERE email = ?", @email)
      if query_result.first.first == 0
        time = Time.now
        @db.execute("INSERT INTO listings (url, title, email, created_at, updated_at) VALUES (?, ?, ?, '#{time}', '#{time}')", @url, @title, @email)
      end
    end

    def send_email_if_unsent(user_email, body)
      # EmailSender.send_email(user_email, @email, @title, body)
      EmailSender.send_email(user_email, 'david@ladowitz.com', @title, body)
      @db.execute("UPDATE listings SET emailed_at = '#{Time.now}' WHERE email = ?", @email)
    end

    def already_in_db
      @db.execute("SELECT COUNT(*) FROM listings WHERE email = ?", @email).first.first == 1
    end

  end

end
