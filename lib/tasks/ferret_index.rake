# ferret_index.rake
desc "Updates the ferret index for the application."
task :ferret_index => [ :environment ] do | t |
  Product.rebuild_index
  # here I could add other model index rebuilds
  puts "Completed Ferret Index Rebuild"
end 