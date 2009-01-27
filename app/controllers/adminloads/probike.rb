require "rubygems"
require "scrapi" # Comes from gem install scrapi


class ProBikeItemInfo < Gdi
  attr_accessor      :title
  
  process "h1",       :_title => :text  #Going to have to do something more with this!! 
  process ".nBuyItNow",       :_priceInfo => :text
#  process ".name",        :_image_url => "@onmouseover"
  process ".name",        :url => "@href"
  process "input[name=CODE]", :external_id => "@value"

  def title
    tmp = @_title.match("(.*)(\\r)")
    tmp[1].to_s
  end

  def provider
    "ProBikeKit"
  end
  
  def image_url
    "http://www.probikekit.com/_img_64x82/" << @external_id << ".jpg"
  end
  
  def url
    p @title
    "http://www.probikekit.com/display.php?code=" << @external_id
  end

  def currency
    "GBP"
  end

  def price
    strMatch = /\d+\.\d+/.match( @_priceInfo)
    strMatch.to_s.to_f
  end

####<table width="100%"
####    cellspacing="0"
####    cellpadding="8"
####    border="0"
####    class="nProductPage">
####      <tbody>
####        <tr>
####          <td width="220" valign="top" align="center">
####            <iframe class="nIframeBox"/>
####            <p class="nPricingTitle">
####                Pricing<br/>(Including VAT)</p>
####            <p class="nSpecialOfferTitle">
####              This item is currently<br/>on special offer.<br/>Regular price £11.73</p>
####      <object height="206" width="206" id="Flash Banner" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000"><param value="imgbanners/10prod.swf" name="movie"/><param value="high" name="quality"/><param value="#FFFFFF" name="bgcolor"/><embed height="206" width="206" type="application/x-shockwave-flash" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" name="Flash Banner" bgcolor="#FFFFFF" quality="high" src="imgbanners/10prod.swf"/></object>
####            <p class="nBuyItNow">Buy It Now For Only <b>£8.99</b></p>
####            <p class="nFreePostBox">
####              <span class="nFreePostTitle">FREE POSTAGE IN </span>
####              <span class="nFreePostCounty">THE UK*</span>
####              <br/>
####              <span class="nFreePostLimit">* Limited time only.<br/>Some items may incur extra handling fees.</span>
####            </p>
####          </td>
####          <td width="76%" valign="top">
####            <table width="100%" cellspacing="0" cellpadding="4" border="0">
####              <tbody>
####                <tr>
####                  <td valign="top">
####                    <h1>Pedros 10mm Campagnolo BB Hex Wrench<br/>
####                      <span class="nBuyItNowLargeBlack">
####                        <strike>RRP £11.73</strike>
####                      </span>
####                      <span class="nBuyItNowLargeBlue">   
####                        <strike>You Save 14.83%</strike>   
####                        <strike>PBK Price £9.99</strike>
####                        <br/>
####                      <span class="nBuyItNowLarge">
####                        Further Reduced By Another 10% Now Only £8.99!!</span>
####                      </span>
####                    </h1>
####                  </td>
####                </tr>
####                <tr>
####                  <td class="nCartBack">
####                    <table width="100%" cellspacing="0" cellpadding="2" border="0" class="nCartBox">
                          ###<tbody>
                          ###  <tr>
                          ###    <td width="50" align="center" class="nCartTitle">Qty</td>
                          ###    <td width="60" align="center" class="nCartTitle">Stock</td>
                          ###    <td align="center" class="nCartTitle">Size/Colour/Option</td>
                          ###    <td align="center" class="nCartTitle">Buy</td>
                          ###  </tr>
                          ###  <tr>
                          ###    <form method="post" action="cart.php"/>
####                          <input type="hidden" value="T0004" name="CODE"/><input type="hidden" value="10mm" name="SUB"/><input type="hidden" value="ADD" name="ACTION"/><td align="center" class="nCartItem"><input type="text" size="3" value="1" name="QTY"/></td><td align="center" class="nCartItem">10+</td><td align="center" class="nCartItem">10mm</td><td align="center" class="nCartItem"><input type="submit" value="Add To Cart" class="nCartSubmit"/></td></tr></tbody></table></td></tr><tr><td height="8"/></tr>
####                          
####                          
####                          <tr>
####                            <td valign="top" class="nProductDesc">
####
####
####
####
####        <p><em><strong>PEDROS</strong><strong> Workshop quality 10mm Hex Key </strong></em></p>
####        <p><em><img hspace="0" height="74" width="70" border="0" align="left" usemap="#ac9044dcdf6825" src="http://www.probikekit.com/images/Lifetime.gif" ismap="ismap"/>Especially designed for bolting together Campagnolo Ultra Torque BB Axle's.</em>
####        </p>
####        <ul>
####          <li>Heat treated tool steel.</li>
####          <li>Large ergonomic handle </li>
####          <li>Ball end and extra long L shape designed especially for Campagnolo ultra torque chainsets </li>
####          <li>Full unlimited warranty on Pedros USA bike tools </li>
####        </ul>
####          </td>
####            </tr>
####            <tr>
####              <td width="100%">
####                <table width="100%" cellspacing="0" cellpadding="2" border="0" class="nAssocBorder">
####                  <tbody>
####                    <tr><td class="nAssocTitle" colspan="2"><a name="ALSO"/>People who bought this also bought...</td></tr>
####                    <tr>  
####                      <td height="30" width="23" class="nAssocBackCol">
####                        <a href="display.php?code=C0364">
####                          <img height="30" width="23" border="0" src="_img_32x41/C0364.jpg"/>
####                        </a>
####                      </td>
####                      <td width="100%" class="nAssocBackCol">
####                        <a href="display.php?code=C0364" class="nAssocItem">Polaris Vortex Glove</a>
####                        <span class="nAssocPrice">£10.34</span>
####                      </td>
####                    </tr>
####                  </tbody>
####                </table>
####              </td>
####            </tr>
####          </tbody>
####        </table>
####      </td>
####    </tr>
####  </tbody>
####
####</table>



end

class ProBikeItem < Scraper::Base
  array :geos
  process ".nProductPage", :geos => ProBikeItemInfo
  result :geos  
end

# ProBike is the main class that will be holding the information 
# that is scraped from ProBike.co.uk
class ProBike 
  
  # items will return an array from the ProBike's website 
  # which will contain all the (first page for now's) information
  def execute(searchText)
    
    @item_identifier = searchText
  
    databack_pbk = nil
    
    EventMachine::run do
      EventMachine::connect "www.probikekit.com", 80, Server do |server_ProBike|

        p "Inside EM Connect(ProBike)"

        long_data = "GET /display.php?code=" << @item_identifier << " HTTP/1.1\r\n"
        long_data = long_data << "Host: www.probikekit.com\r\n\r\n"
        
        p long_data

        server_ProBike.send_data(long_data)
        p ("Sent ProBike Data")
        databack_pbk = server_ProBike.getdata
      
      end
    
    end
    
    p "ProBike EM Ended"

    #Scraping ProBike
    return_array = ProBikeItem.scrape(databack_pbk)

    if (return_array != nil)   
      a = return_array
      p "ProBikeKit Array Length " <<  a.length.to_s
      a.each  do |loc|
        p "Writing " << loc.title
        loc.write()
      end
    else
      p "ProBikeKit return array was empty... try again"
    end

  end
  
end
