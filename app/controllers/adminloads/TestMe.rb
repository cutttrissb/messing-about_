#!/usr/bin/env ruby
require "sqlite3"

require "full_search"

class WriteToDataBase
  def write (gdi)
    # We are going to pass in generic_item and process it into the database
    db = SQLite3::Database.open( '..\\BikeForum\\db\\development.sqlite3')
    db.execute( "delete from products where provider=? and (external_id = ? or title = ?)", gdi.provider, gdi.external_id, gdi.title)
    db.execute( "insert into products (title, price, currency,url,image_url,external_id, rrp, in_stock, created_at, updated_at, provider) values ( ?, ?, ?, ?, ?, ?, ?, ?, Datetime('Now'), ?, ?)", gdi.title, gdi.price, gdi.currency, gdi.url,gdi.image_url, gdi.external_id, gdi.rrp, gdi.in_stock, gdi.updated_at, gdi.provider)

#    db.execute( "insert into products_archive (title, price, currency,external_id,created_at, updated_at, provider) values ( ?, ?, ?, ?, ?, ?, ?, ?, Datetime('Now'), ?, ?)", gdi.title, gdi.price, gdi.currency, gdi.url,gdi.image_url, gdi.external_id, gdi.rrp, gdi.in_stock, gdi.updated_at, gdi.provider)
    db.close    
  end
end

a = WriteToDataBase.new()

pbk_arr = []

pbk_arr <<  Wiggle.new("shimano").items
pbk_arr << ProBike.new("T0004").items
pbk_arr <<  ProBike.new("NP05438").items
pbk_arr <<  ProBike.new("NP05439").items
pbk_arr <<  ProBike.new("NP05440").items
###pbk_arr <<  ProBike.new("NP05441").items
###pbk_arr <<  ProBike.new("NP05442").items
###pbk_arr <<  ProBike.new("NP05443").items
###pbk_arr <<  ProBike.new("NP11759").items
###pbk_arr <<  ProBike.new("NP11762").items
###pbk_arr <<  ProBike.new("NP11760").items
###pbk_arr <<  ProBike.new("D1057").items
###pbk_arr <<  ProBike.new("A1201").items
###pbk_arr <<  ProBike.new("A1242").items
###pbk_arr <<  ProBike.new("NP01315").items
###pbk_arr <<  ProBike.new("NP01002").items
###pbk_arr <<  ProBike.new("A0035").items
###pbk_arr <<  ProBike.new("D1090").items
###pbk_arr <<  ProBike.new("D6050").items
###pbk_arr <<  ProBike.new("D1054").items
###pbk_arr <<  ProBike.new("D1055").items
###pbk_arr <<  ProBike.new("D1050").items
###pbk_arr <<  ProBike.new("D1056").items
###pbk_arr <<  ProBike.new("D1052").items
###pbk_arr <<  ProBike.new("D1051").items
###pbk_arr <<  ProBike.new("K1014").items
###pbk_arr <<  ProBike.new("D0003").items
###pbk_arr <<  ProBike.new("M8006").items
###pbk_arr <<  ProBike.new("M8003").items
###pbk_arr <<  ProBike.new("T4430").items

pbk_arr.each {|w|
  w.each {|loc|a.write(loc)} 
}  
