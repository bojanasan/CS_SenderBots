require './web_handler.rb'

module UIHandler


  def run
      puts"Welcome to CL crawler."
      puts "Please select one of the following options: [monitor, history, unmonitor]"
      command = ""
      printf "enter command: "
      command = gets.chomp
      while command != "quit"
        puts ""

        case command
           when 'monitor'
             puts "Please give me a URL to monitor."
             print "URL: "
             url = gets.chomp
             puts "We are now monitoring #{url}"
             puts "All matching listings will be sent an email on your behalf."
             WebHandler::get_listings_from_url(url)
             command = "quit"

           when 'history'
              puts "Here is your history: blah blah blah"
              #show all history
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


end

include UIHandler
UIHandler.run