require "rubygems"
require "scrapi" # Comes from gem install scrapi
require 'C:\Ruby\lib\ruby\gems\1.8\gems\scrapi-1.2.0\lib\scrapi.rb'
# Gdi will be used as a generic item that will be used to display
# information on the web page for every item.  Regardless of the implementation.

require 'eventmachine'

include EM::Protocols

class Gdi < Scraper::Base
  attr_accessor      :title, :price,:description,:url,:image_url,:currency,:external_id,:rrp,:in_stock,:created_at,:updated_at,:provider

  def write( base_currency, exchange_rate) 
    # We are going to pass in generic_item and process it into the database
    db = SQLite3::Database.open( '\Ruby\TutorialRails\BikeForum\db\development.sqlite3')
    db.execute( "delete from products where provider=? and (external_id = ? or title = ?)", provider, external_id, title)
    db.execute( "insert into products (title, display_currency, price, currency,url,image_url,external_id, rrp, in_stock, created_at, updated_at, provider) values ( ?, ?, ?, ?, ?, ?, ?, ?, ?, Datetime('Now'), ?, ?)", title, price.to_f * exchange_rate,  price, exchange_rate, url,image_url, external_id, rrp, in_stock, updated_at, provider)
    db.close
  end

end

class Server < EventMachine::Connection
    attr_accessor :options, :status  #, :searchText

  def initialize *args
    super
  end

  # Need to define dataA
  @return_data 
  
  def initialize
    @return_data = ""
  end
  
  def post_init
    @return_data = "" 
  end
  
  def getdata
    @return_data
  end
  
  def receive_data(data)
    p "Receive data"
    
    @return_data << data
    if (data.match("</html>") )
      p "Found end HTML - should be killing outselves..."
    end
  end
 
  def unbind
    p "Unbind"
    if @data =~ /[\n][\r]*[\n]/m
      $`.each {|line| puts ">>> #{line}" }
    end
   
    EventMachine::stop_event_loop
  end
end
