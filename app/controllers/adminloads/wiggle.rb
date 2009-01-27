require "rubygems"
require "scrapi" # Comes from gem install scrapi

class WiggleItemInfo < Gdi

  process "strong",       :title => :text
  process ".price",       :_priceInfo => :text
  process ".name",        :_image_url => "@onmouseover"
  process ".name",        :url => "@href"

###<a class="name"
###  href="http://www.wiggle.co.uk/p/Cycle/7/Shimano_105_FC5600_Bottom_Bracket_Cup_Set/5360020765/"
###  onmouseover="document.images.img5360020765.src='http://www.wiggle.co.uk/images/shimano-bb5600b-ind.jpg'"
###  onmouseout="document.images.img5360020765.src='http://www.wiggle.co.uk/images/loading.gif'">
###    Shimano 105 FC5600 Bottom Bracket Cup Set
###    <span class="hidden">
###      <img
###            align="right"
###            name="img5360020765"
###            src="http://www.wiggle.co.uk/images/loading.gif"
###            class="picBorder"
###              alt="Shimano 105 FC5600 Bottom Bracket Cup Set"/>
###        <strong>Shimano 105 FC5600 Bottom Bracket Cup Set</strong>
###        <br/>
###        <br/>£12.22
###<p>In stock options</p>
###<ul class="tooledin"><li> English</li><li> Italian</li></ul>
###</span>
###</a>

  # Get the image from the information provided: except it can't have the ' at the end...
  def image_url
    if (@_image_url != nil)
      #p "Image URL" << @_image_url
      @_image_url = @_image_url.match("http[^\']*").to_s
      #p "Image URL" << @_image_url
      @_image_url
    else
      ""
    end
  end

  #price will contain the pricing information for the item.  (We will work on currency later on)
  def price
    # Find the number in the form dddd.dd.
    # The RegEx returns a MatchSet from which we need to get the number.
    strMatch = /\d+\.\d+/.match( @_priceInfo)
    strMatch.to_s.to_f
  end

  # Override the provider accessor
  def provider
    @provider = "WIGGLE"
  end
  
  # Override the currency accessor (for now)
  def currency
    @curreny = "GBP"
  end
end

class WiggleItem < Scraper::Base
  array :geos
  process ".fullrangeitem", :geos => WiggleItemInfo
  result :geos  
end

# Wiggle is the main class that will be holding the information 
# that is scraped from wiggle.co.uk
class Wiggle 
  
  # items will return an array from the Wiggle's website 
  # which will contain all the (first page for now's) information
  def execute(searchText)
  
    @search_string = searchText
    
    dataBack_pbk = nil
    dataBack_wiggle = nil
    
    EventMachine::run do
      EventMachine::connect "www.wiggle.co.uk", 80, Server do |server_wiggle|

        #p "Inside EM Connect(Wiggle)"

        long_data = "GET /m/Cycle/7/" << @search_string << "/ HTTP/1.1\r\n"
        long_data = long_data << "Host: www.google.com\r\n"
        long_data = long_data << "Connection: close\r\n\r\n"

        p long_data
        server_wiggle.send_data(long_data)
        #p ("Sent Wiggle Data")
        dataBack_wiggle = server_wiggle.getdata
      
      end
    
    end
  
    #Scraping Wiggle
    return_array = WiggleItem.scrape(dataBack_wiggle)

    if (return_array != nil)   
      a = return_array
      p "Wiggle Array Length " <<  a.length.to_s
      a.each  do |loc|
        p "Writing " << loc.title
        loc.write()
      end
    else
      p "Wiggle return array was empty... try again"
    end
    
  end
  
end
