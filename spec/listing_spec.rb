require 'rspec'
require 'simplecov'
SimpleCov.start
require './listing.rb'

describe 'Listing' do
  url = 'http://sfbay.craigslist.org/sfc/apa/3129154467.html'
  title = '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta'
  email = 'hzzf4-3129154467@hous.craigslist.org'

  after :all do
    db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
    db.execute('DELETE FROM listings')
  end

  describe '#initialize' do
    it "raises an error if it doesn't receive an email" do
      lambda { CraigslistMonitor::Listing.new({ :url => url, :title => title }) }.should raise_error
    end

    it "raises an error if it doesn't receive a url" do
      lambda { CraigslistMonitor::Listing.new({ :title => title, :email => email }) }.should raise_error
    end

    it "raises an error if it doesn't receive a title" do
      lambda { CraigslistMonitor::Listing.new({ :url => url, :email => email }) }.should raise_error
    end
  end

  describe 'methods that talk to the db' do

    before :each do
      @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
      SQLite3::Database.stub(:new).and_return(@db)
      EmailSender.stub(:send_email).and_return(true)
      @time_now = Time.now
      Time.stub(:now).and_return(@time_now)

      @listing = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                                :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
                                                :email => 'hzzf4-3129154467@hous.craigslist.org'})

      @db.execute('DELETE FROM listings')
      @listing.store_to_db
    end    

    describe '#store_to_db' do
      it 'stores a new row in the db if the listing is new' do
        @db.execute("SELECT * FROM listings WHERE url='http://sfbay.craigslist.org/sfc/apa/3129154467.html'").first.slice(1..-1).should eq ["http://sfbay.craigslist.org/sfc/apa/3129154467.html", "$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta", "hzzf4-3129154467@hous.craigslist.org", nil, @time_now.to_s, @time_now.to_s]
      end

      it 'doesnt create duplicate rows if the listing already exists' do
        @listing.store_to_db
        @listing.store_to_db
        @db.execute("SELECT COUNT(*) FROM listings WHERE url='http://sfbay.craigslist.org/sfc/apa/3129154467.html' GROUP BY url").first.first.should eq 1
      end

    end

    describe '#send_email_if_unsent' do
      it 'sends an email to the EmailSender module' do
        EmailSender.should_receive(:send_email).with('user@example.com', 'hzzf4-3129154467@hous.craigslist.org', '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta', 'test')
        @listing.send_email_if_unsent('user@example.com','test')
      end

      it 'marks the listing as sent in the db' do
        @listing.send_email_if_unsent('user@example.com','test')
        @db.execute("SELECT emailed_at FROM listings WHERE email = 'hzzf4-3129154467@hous.craigslist.org'").first.first.should eq @time_now.to_s
      end
    end

    describe '#already_in_db?' do
      it 'returns true if the listing is stored in the db' do
        @listing.already_in_db?.should be true
      end

      it 'returns false if it isnt' do
        @db.execute('DELETE FROM listings')
        @listing.already_in_db?.should be false
      end
    end
  end
end



