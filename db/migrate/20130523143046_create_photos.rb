class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :desc
      t.string :image
      t.integer :score

      t.timestamps
    end
  end
end
