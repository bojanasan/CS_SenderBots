require 'rspec'
require 'simplecov'
SimpleCov.start
require './web_handler.rb'


describe '#get_new_listings_from_url' do
  url = './spec/html/sample.html'

  before :each do
    @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
    SQLite3::Database.stub(:new).and_return(@db)
    @db.execute('DELETE FROM listings')
  end

  it 'filters out entries with no email' do
    WebHandler::get_new_listings_from_url(url).count.should eq 2
  end

  it 'gives us an array with the correct list objects' do
    WebHandler::get_new_listings_from_url(url).map { |listing| listing.url}.should eq ["./spec/html/listing1.html", "./spec/html/listing2.html"]
  end

  it 'doesnt add a listing to the returned array if the listing email is already in the database' do
    listing = CraigslistMonitor::Listing.new({:url => './spec/html/listing1.html',
                                              :title => '$2700 / 3br - 1300ft&sup2; - Large, bright Ingleside home',
                                              :email => 'wpqcj-3128932974@hous.craigslist.org'})
    listing.store_to_db
    
    WebHandler::get_new_listings_from_url(url).map { |listing| listing.url}.should eq ["./spec/html/listing2.html"]

    @db.execute('DELETE FROM listings')
  end
end
