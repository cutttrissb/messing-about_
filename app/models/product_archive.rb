class ProductArchive < ActiveRecord::Base
  attr_accessor :title, :price, :currency, :external_id, :created_at, :provider

end
