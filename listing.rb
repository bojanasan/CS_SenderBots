require 'sqlite3'
require './mailgun.rb'
# require './craigslist.sqlite3'
require './database_setup'


module CraigslistMonitor

  class Listing < ActiveRecord::Base
    # attr_reader :url, :title, :email
    #    # def initialize(opts = {})
    #    #   # @url   = opts.fetch(:url)   { raise Error }
    #    #   # @title = opts.fetch(:title) { raise Error }
    #    #   # @email = opts.fetch(:email) { raise Error }
    #    #   # @db = SQLite3::Database.new "./craigslist_monitor.db"
    #    # end
    #
    #    def store_to_db
    #      query_result = Listing.find_by_authors_email(@email)
    #      if query_result == nil
    #        new_listing = Listing.new(:url => @url, :title => @title, :authors_email => @email)
    #        puts new_listing.inspect
    #        # new_listing.save
    #      end
    #      #   time = Time.now
    #      #   @db.execute("INSERT INTO listings (url, title, email, created_at, updated_at) VALUES (?, ?, ?, '#{time}', '#{time}')", @url, @title, @email)
    #      # end
    #    end
    #
    #    def send_email_if_unsent(user_email, body)
    #      #EmailSender.send_email(user_email, @email, @title, body)
    #      EmailSender.send_email(user_email, 'david@ladowitz.com', @title, body)
    #      @db.execute("UPDATE listings SET emailed_at = '#{Time.now}' WHERE email = ?", @email)
    #    end
    #
    #    def already_in_db?
    #      @db.execute("SELECT COUNT(*) FROM listings WHERE email = ?", @email).first.first == 1
    #    end

  end

end


my_monitor = CraigslistMonitor::Listing.new(:url => "www.com", :title => "test title", :authors_email => "a@a.com")
if my_monitor.save
  puts "yay!"
else
  puts "nay!"
end
puts my_monitor.title
# lachy = CraigslistMonitor::Listing.find_by_email("lachy@devbootcamp.com")
# puts lachy.title
# puts lachy.email

# my_monitor.store_to_db