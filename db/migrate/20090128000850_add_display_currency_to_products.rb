class AddDisplayCurrencyToProducts < ActiveRecord::Migration
  def self.up
     add_column "products", "display_currency", :string
  end

  def self.down
    remove_column "products", "display_currency"
  end
end
