require './web_handler.rb'
require './mailgun.rb'
require 'sqlite3'


module UIHandler

  def self.run

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
             email = gets.chomp
             puts ""

             puts "What contact name would you like to provide in the email?"
             print "Name: "
             name = gets.chomp
             puts ""



             body = "Hello! I saw your listing on Craigslist and I am really interest at taking a look in person." \
                    "Please let me know if it's still available and what would be a good time to meet." \
                    "" \
                    "Thank you!"\
                    "#{name}"


                   running = ""
                   counter = 0
                   WebHandler::get_new_listings_from_url(url).each { |listing| listing.store_to_db }
                   any_email_sent = false
                   while running != 'stop'
                     sleep 2
                     puts "monitoring web page"
                     counter +=1
                     if counter % 5 == 0
                       WebHandler::get_new_listings_from_url(url).each do |listing|
                         listing.store_to_db
                         listing.send_email_if_unsent(email, body)
                         puts "email sent!"
                         any_email_sent = true
                       end
                       puts "no emails sent this time period" unless any_email_sent
                       any_email_sent = false
                     end

                   end





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

  def self.show_history
    @db = SQLite3::Database.new "./craigslist_monitor.db"
    listing_row = @db.execute('SELECT title, url, email, updated_at FROM listings')

    listing_row.each do |row|
          puts "Title: #{row[0]}"
          puts "URL: #{row[1]}"
          puts "Email sent to: #{row[2]}"
          puts "Email sent out at: #{row[3]}"
          puts ""
    end

  end

end

UIHandler.run