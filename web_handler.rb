require 'nokogiri'
require 'open-uri'
require './listing.rb'

module WebHandler
  def self.get_listings_from_url(url)
    results = []
    search_page = Nokogiri::HTML(open(url))
    search_page.css('p.row span+a').each do |link|
      listing_options = {}
      listing_options[:title] = link.content
      listing_options[:url] = link['href']
      listing_page = Nokogiri::HTML(open(link['href']))

      unless listing_page.css('span.returnemail a')[0].nil?
        listing_options[:email] = listing_page.css('span.returnemail a')[0].content
        results << CraigslistMonitor::Listing.new(listing_options)
      end
    end

    return results
  end
end

