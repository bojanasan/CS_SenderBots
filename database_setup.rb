require 'active_record'
require 'sqlite3'

ActiveRecord::Base.establish_connection(
  :adapter => 'sqlite3',
  :database => './db/craigslist.sqlite3'
)

unless File.exists?('./db/craigslist.sqlite3')
  puts 'creating database'


  ActiveRecord::Schema.define do
    create_table :listings do |table|
      table.column :url, :string
      table.column :title, :string
      table.column :authors_email, :string
      table.column :emailed_at, :datetime
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
    end

    create_table :user_inputs do |table|
      table.column :user_name, :string, :null => false
      table.column :user_email, :string, :null => false
      table.column :search_url, :string, :null => false
      table.column :created_at, :datetime
      table.column :updated_at, :datetime
    end

  end

end