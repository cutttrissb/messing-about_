class CreateProductArchives < ActiveRecord::Migration
  def self.up
    create_table :product_archives do |t|
      t.string :title
      t.string :price
      t.string :currency
      t.string :external_id
      t.datetime :created_at
      t.string :provider

      t.timestamps
    end
  end

  def self.down
    drop_table :product_archives
  end
end
