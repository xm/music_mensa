class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.integer :artist_id, null: false
      t.string :name, null: false
      t.string :kind, null: false
      t.date :release_date

      t.timestamps
    end
    add_index :albums, :artist_id
  end
end
