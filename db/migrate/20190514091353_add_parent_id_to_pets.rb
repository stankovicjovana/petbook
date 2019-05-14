class AddParentIdToPets < ActiveRecord::Migration[5.2]
  def change
    add_column :pets, :parent_id, :integer
  end
end
