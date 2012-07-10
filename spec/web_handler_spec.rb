require 'rspec'
require 'simplecov'
SimpleCov.start
require './web_handler.rb'


describe '#get_listings_from_url' do

  it 'gives us an array of listing objects' do
    url = './spec/html/sample.html'
    Nokogiri::HTML(open(url))
    WebHandler::get_listings_from_url(url).count.should eq 2
  end
end



