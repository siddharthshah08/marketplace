class AddLowestBidIdToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :lowest_bid_id, :integer
  end
end
