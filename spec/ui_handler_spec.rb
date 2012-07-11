require 'rspec'
require "./ui_handler.rb"
require "./ui_handler.rb"



describe "UIHandler Module" do

  before :each do
    @db = SQLite3::Database.new "./spec/craigslist_monitor_test.db"
    SQLite3::Database.stub(:new).and_return(@db)

    @listing = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/3129154467.html',
                                              :title => '$3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta',
                                              :email => 'hzzf4-3129154467@hous.craigslist.org'})

    # @listing2 = CraigslistMonitor::Listing.new({:url => 'http://sfbay.craigslist.org/sfc/apa/20934819249.html',
    #                                              :title => '$2500 / 2br - 789ft - Large, Modern & More-Come home to Argenta',
    #                                              :email => 'hzzf4-31239273987@hous.craigslist.org'})

   @time_now = Time.now
    Time.stub(:now).and_return(@time_now)
    @db.execute('DELETE FROM listings')
  end

  it "should show a history of emails send on the users behalf" do
    time = Time.now
    @listing.store_to_db
    # @listing2.store_to_db

    STDOUT.should_receive(:puts).with("Title: $3244 / 1br - 789ft - Large, Modern & More-Come home to Argenta")
    STDOUT.should_receive(:puts).with("URL: http://sfbay.craigslist.org/sfc/apa/3129154467.html")
    STDOUT.should_receive(:puts).with("Email sent to: hzzf4-3129154467@hous.craigslist.org")
    STDOUT.should_receive(:puts).with("Email sent out at: #{@time_now}")
    STDOUT.should_receive(:puts).with("")
    UIHandler.show_history

  end

end

