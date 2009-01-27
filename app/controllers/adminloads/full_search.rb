require "generic_display_item"
require "probike"
require "wiggle"

class FullSearch
  def do_search(searchText)
    @searchString = searchText
    #p "Calling ProBike search"
    w = Wiggle.new(@searchString).items
    #w = ProBike.new(@searchString).items
    #p "Calling Wiggle search"
    #w1 = nil
    
    ##if (w == nil)
    ##  p "PBK was empty?"
    ##elsif
    ##  p w.length
    ##end
    ##
    ##if (w1 == nil)
    ##  p "Wiggle was empty"
    ##elsif
    ##  p w1.length
    ##end
    
    ##if (w != nil && w1 != nil)
    ##  p "Copied arrays together?"
    ##  w = w + w1
    ##elsif (w1 != nil && w == nil)
    ##  w = w1
    ##elsif (1)
    ##  p "Weird location here!"
    ##end
    
    ##if (w != nil)
    ##  w.sort! { |a,b| a.price <=> b.price }
    ##end
    ##p w.length
    w
  end
  
  def items
    @w1
  end 
end
