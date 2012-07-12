require "rest-client"

module EmailSender

    def self.send_email(user_email, listing_email, listing_title, body)

      puts "email sent to david!"

      # DO NOT DELETE OR WE WILL KILL YOU!!! THIS IS NEEDED FUNCTIONALITY!!!!!

      # RestClient.post "https://api:key-903saomu7owoeibd0pur22m-ct109sw0"\
      #     "@api.mailgun.net/v2/senderbots.mailgun.org/messages",
      #      :from => user_email ,
      #      :to => listing_email ,
      #      :subject => listing_title ,
      #      :text => body

       # DO NOT DELETE OR WE WILL KILL YOU!!! THIS IS NEEDED FUNCTIONALITY!!!!!

    end

end

