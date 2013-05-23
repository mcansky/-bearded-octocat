class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.text :desc
      t.string :image
      t.integer :score, :default => 0

      t.timestamps
    end
  end
end
