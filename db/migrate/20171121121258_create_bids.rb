class CreateBids < ActiveRecord::Migration[5.1]
  def change
    create_table :bids do |t|
      t.float :rate
      t.float :bid_amount
      t.string :rate_type
      t.references :buyer, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
