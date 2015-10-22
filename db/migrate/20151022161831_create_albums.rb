class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :band_id
      t.string :venue

      t.timestamps null: false
    end

    add_index :albums, :band_id
    add_foreign_key :albums, :bands
  end
end
