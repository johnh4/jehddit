class AddOpIdToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :op_id, :integer
  end
end
