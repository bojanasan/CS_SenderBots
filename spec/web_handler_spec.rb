require 'rspec'
require 'simplecov'
SimpleCov.start
require './web_handler.rb'


describe '#get_listings_from_url' do
  it 'filters out entries with no email' do
    url = './spec/html/sample.html'
    Nokogiri::HTML(open(url))
    WebHandler::get_listings_from_url(url).count.should eq 2
  end

  it 'gives us an array with the correct list objects' do
    url = './spec/html/sample.html'
    Nokogiri::HTML(open(url))
    WebHandler::get_listings_from_url(url).map { |listing| listing.url}.should eq ["./spec/html/listing1.html", "./spec/html/listing2.html"]
  end
end



