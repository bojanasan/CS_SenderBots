require 'rspec'
require "./ui_handler.rb"


describe "UIHandler Module" do

  before :each do
    @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
    SQLite3::Database.stub(:new).and_return(@db)

    @listing = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                              :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
                                              :email => 'hzzf4-3129154467@hous.craigslist.org'})
    @time_now = Time.now
    Time.stub(:now).and_return(@time_now)
    @db.execute('DELETE FROM listings')
  end

  it "should show a history of emails send on the users behalf" do
    time = Time.now
    @listing.store_to_db
    UIHandler.show_history.should eq("Title: $3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta ; URL: http://sfbay.craigslist.org/sfc/apa/3129154467.html ; Listing Email: hzzf4-3129154467@hous.craigslist.org ; #{@time_now } "  )
  end

end

