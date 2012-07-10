require 'rspec'
require 'simplecov'
SimpleCov.start
require './listing.rb'

describe 'Listing' do



  describe '#initialize' do
    it "raises an error if it doesn't receive an email" do
      lambda { CraigslistMonitor::Listing.new({   :url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                                  :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta' }) }.should raise_error
    end

    it "raises an error if it doesn't receive a url" do
      lambda { CraigslistMonitor::Listing.new({ :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
                                                :email => 'hzzf4-3129154467@hous.craigslist.org'}) }.should raise_error
    end

    it "raises an error if it doesn't receive a title" do
      lambda { CraigslistMonitor::Listing.new({ :url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                                :email => 'hzzf4-3129154467@hous.craigslist.org' }) }.should raise_error
    end


  end

  describe '#store_to_db' do
    before :each do
      @listing = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                                :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
                                                :email => 'hzzf4-3129154467@hous.craigslist.org'})
      @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
      SQLite3::Database.stub(:new).and_return(@db)
      @time_now = Time.now
      Time.stub(:now).and_return(@time_now)
      @db.execute('DELETE FROM listings')
    end

    it 'stores a new row in the db if the listing is new' do
      @listing.store_to_db
      puts  @db.execute("SELECT * FROM listings").inspect
      @db.execute("SELECT * FROM listings WHERE url='http://sfbay.craigslist.org/sfc/apa/3129154467.html'").first.slice(1..-1).should eq ["http://sfbay.craigslist.org/sfc/apa/3129154467.html", "$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta", "hzzf4-3129154467@hous.craigslist.org", nil, @time_now.to_s, @time_now.to_s]
    end

    it 'doesnt do anything if the listing is old' do
      @listing.store_to_db
      @listing.store_to_db
      @db.execute("SELECT COUNT(*) FROM listings WHERE url='http://sfbay.craigslist.org/sfc/apa/3129154467.html' GROUP BY url").first.first.should eq 1
    end

  end

  # describe '#send_email_if_unsent' do
  #     before :each do
  #       @listing = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
  #                                                 :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
  #                                                 :email => 'hzzf4-3129154467@hous.craigslist.org'})
  #       @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
  #       SQLite3::Database.stub(:new).and_return(@db)
  #     end
  # end
end