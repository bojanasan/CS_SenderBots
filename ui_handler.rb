require './web_handler.rb'
require './mailgun.rb'

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
           # puts "Please give me a URL to monitor."
           #           print "URL: "
           #           url = gets.chomp
           #           puts "All matching listings will be sent an email on your behalf."
           #           puts "What email address would you like to use to send correspondence from?"
           #           puts "Email: "
           #           email = gets.chomp

           puts "What contact name would you like to provide in the email?"
           print "Name: "
           $name = gets.chomp
           # puts "We are now monitoring #{url}"


                   running = ""
                   counter = 0
                   while running != 'stop'
                     sleep 2
                     puts "monitoring web page"
                     counter +=1
                     if counter % 5 == 0
                       puts "We just sent out emails for you"
                       EmailSender::send_email('david@ladowitz.com', 'david@aronsontech.com', '$1335 / 1br - 1 BR APARTMENT WALKING DISTANCE TO UC BART! ONLY $1335! (fremont / union city / newark)' )
                       # WebHandler::get_listings_from_url(url).each {|listing| listing.send_mail_if_unsent}
                     end

                   end





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