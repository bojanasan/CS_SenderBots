require 'sqlite3'


module CraigslistMonitor

  class Listing
    def initialize(opts = {})
      @url   = opts.fetch(:url)   { raise Error }
      @title = opts.fetch(:title) { raise Error }
      @email = opts.fetch(:email) { raise Error }
    end

  end

end