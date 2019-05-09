class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :title
      t.text :description
      t.belongs_to :pet, foreign_key: true

      t.timestamps
    end
  end
end
