require 'sqlite3'
require './mailgun.rb'
require './database_setup'
require './web_handler.rb'
require './listing.rb'

class User_input < ActiveRecord::Base
  def run
    puts "Welcome to the Craislist Monitor."
    puts "We can monitor a Craigslist page for new listsings or show you a history of activity"
    puts ""
    puts "Please select one of the following options: [monitor, history]"
    command = ""
    print "Enter command: "
    command = gets.chomp

    while command != "quit"
      puts ""

      case command
      when 'monitor'
         puts "Please give me a URL to monitor."
         print "URL: "
         url = gets.chomp

         puts ""
         puts "We are now monitoring #{url}"
         puts "All matching listings will be sent an email on your behalf."
         puts ""

         puts "What email address would you like to use to send correspondence from?"
         print "Email: "
         user_email = gets.chomp
         puts ""

         puts "What contact name would you like to provide in the email?"
         print "Name: "
         user_name = gets.chomp
         puts ""

         user_input = User_input.create(:search_url => url, :user_email => user_email, :user_name => user_name, :created_at => Time.now, :updated_at => Time.now)

         WebHandler::get_new_listings_from_url(url).each do |listing|
           listing.send_email(user_name, user_email)
           puts "email sent"
         end

         command = "quit"

      when 'history'
        puts "Here is your history:\n"
        show_history
        command = "quit"

      when 'unmonitor'
        puts "We've stopped monitoring all craigslist pages,"
        #stop monitoring stored URL and confirm that the stored URL is no longer being monitored
        command = "quit"

      else
        puts "Sorry, I don't know how to (#{command})"
      end

    end
  end

  def show_history
    CraigslistMonitor::Listing.all.each do |listing|
      puts "Title: #{listing.title}"
      puts "URL: #{listing.url}"
      puts "Email sent to: #{listing.authors_email}"
      puts "Email sent out at: #{listing.emailed_at}"
      puts ""
    end
  end
end

my_input = User_input.new
my_input.run
