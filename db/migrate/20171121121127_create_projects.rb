class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.string :status
      t.datetime :starts_at
      t.datetime :ends_at
      t.datetime :accepting_bids_till
      t.references :seller, foreign_key: true

      t.timestamps
    end
  end
end
