class CreatePets < ActiveRecord::Migration[5.2]
  def change
    create_table :pets do |t|
      t.string :name
      t.text :description
      t.string :type
      t.string :breed
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
