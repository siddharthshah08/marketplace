class AddStatusToBids < ActiveRecord::Migration[5.1]
  def change
    add_column :bids, :status, :string
  end
end
