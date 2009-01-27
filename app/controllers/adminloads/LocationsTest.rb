require "full_search"

puts("Enter search")
searchString = gets

#w = Wiggle.new(searchString)

#items.each {|loc| puts "[#{loc.priceInfo} x #{loc.productTitle} x #{loc.imageInfo} x #{loc.href}]" }
#puts @newarray[0].class

a = FullSearch.new
b = a.do_search(searchString)

#w.items.each {|loc| puts "[#{loc.Price} x #{loc.productTitle} x #{loc.imageInfo} x #{loc.href}]" }
b.each {|loc| puts "[#{loc.price} x #{loc.productTitle} x #{loc.provider}]" }
