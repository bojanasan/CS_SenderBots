require "rest-client"

module EmailSender

    def self.send_email(user_email, listing_email, listing_title)

      RestClient.post "https://api:key-3ax6xnjp29jd6fds4gc373sgvjxteol0"\
         "@api.mailgun.net/v2/samples.mailgun.org/messages",
         :from => user_email ,
         :to => listing_email ,
         :subject => listing_title ,
         :text => "Hello! I saw your listing on Craigslist and I am really itneresting at taking a look in person." \
         "Please let me know if it's still available and what would be a good time to take a look." \
         "" \
         "Thank you!"\
         "#{$name}"
    end

end

# puts " Hello #{$name}"
# include EmailSender
# send_email('david@ladowitz.com', 'david@aronsontech.com', '$1335 / 1br - 1 BR APARTMENT WALKING DISTANCE TO UC BART! ONLY $1335! (fremont / union city / newark)' )
# puts "seems to have worked"
