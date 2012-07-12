require 'sqlite3'
require './mailgun.rb'
# require './craigslist.sqlite3'
require './database_setup'


module CraigslistMonitor

  class Listing < ActiveRecord::Base
    def send_email(users_name, users_email)
      body = "Hello! I saw your listing on Craigslist and I am really interest at taking a look in person.\n" \
              "Please let me know if it's still available and what would be a good time to meet.\n" \
              "\n" \
              "Thank you!\n"\
              "#{users_name}"

      EmailSender.send_email(users_email, 'david@ladowitz.com', self.title, body)
      self.emailed_at = Time.now
      self.save
    end

  end

end
