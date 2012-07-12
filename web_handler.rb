require 'nokogiri'
require 'open-uri'
require './listing.rb'

module WebHandler
  def self.get_new_listings_from_url(url)
    results = []
    search_page = Nokogiri::HTML(open(url))
    search_page.css('p.row span+a').each do |link|
      listing_options = {}
      listing_options[:title] = link.content
      listing_options[:url] = link['href']
      listing_page = Nokogiri::HTML(open(link['href']))

      unless listing_page.css('span.returnemail a')[0].nil?
        listing_options[:authors_email] = listing_page.css('span.returnemail a')[0].content
        new_listing = CraigslistMonitor::Listing.find_or_create_by_title_and_url_and_authors_email(listing_options)
        results <<  new_listing
      end
    end

    return results
  end
end