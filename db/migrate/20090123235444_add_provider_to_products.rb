class AddProviderToProducts < ActiveRecord::Migration
  def self.up
     add_column "products", "provider", :string
  end

  def self.down
    remove_column "products", "provider"
  end
end

##
##class AddCreationDateToWeblogs < ActiveRecord::Migration
##  def self.up
##    add_column "weblogs", "created", :datetime
##  end
##
##  def self.down
##    remove_column "weblogs", "created"
##  end
##end