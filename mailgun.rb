require "rest-client"

module EmailSender

    def self.send_email(user_email, listing_email, listing_title, body)

      RestClient.post "https://api:key-903saomu7owoeibd0pur22m-ct109sw0"\
        "@api.mailgun.net/v2/senderbots.mailgun.org/messages",
         :from => user_email ,
         :to => listing_email ,
         :subject => listing_title ,
         :text => body

    end

end


# include EmailSender
#
#  body = "Hello! I saw your listing on Craigslist and I am really itneresting at taking a look in person." \
#         "Please let me know if it's still available and what would be a good time to take a look." \
#         "" \
#         "Thank you!"\
#         "Bojana"
#
#
# EmailSender::send_email('david@ladowitz.com', 'david@aronsontech.com', '$1335 / 1br', body)
#
# puts "seems to have worked"

