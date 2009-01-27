class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :title
      t.float :price
      t.string :description
      t.string :url
      t.string :image_url
      t.string :currency
      t.string :external_id
      t.float :rrp
      t.string :in_stock

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
