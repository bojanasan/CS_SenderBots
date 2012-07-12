require 'sinatra'
require './user_input.rb'
require 'active_record'
require 'sqlite3'
require './database_setup.rb'
require './web_handler.rb'

get '/' do
  erb :index
end

get '/history' do
  erb :history
end

post '/' do
  p params
  search_url = params[:search_url].to_s
  user_name = params[:user_name].to_s
  user_email = params[:user_email].to_s
  UserInput.create(:search_url => search_url, :user_email => user_email, :user_name => user_name)
  send_emails
end

get '/test' do
  if UserInput.create(:search_url => "HTTP://test.example.com", :user_email => "me@ex.com", :user_name => "Bob")
    @test_result = "Success!"
  else
    @test_result = "Failure"
  end
  erb :test
end


# def send_emails
#   puts "*************"
#   puts UserInput.all[0].inspect
#   puts "*************"
#
#   UserInput.all.each do |object|
#     puts "email sent!"
#   end
#
#   # WebHandler::get_new_listings_from_url(UserInput.all).each do |listing|
#   #         # listing.send_email(UserInput.user_name, UserInput.user_email)
#   #         puts "email sent"
#   #       end
# end