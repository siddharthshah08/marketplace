class AddPqToProjects < ActiveRecord::Migration[5.1]
  def change
     add_column :projects, :pq, :binary
  end
end
