class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.integer :album_id
      t.string :title
      t.string :bonus
      t.text :lyrics

      t.timestamps null: false
    end

    add_index :tracks, :album_id
    add_foreign_key :tracks, :albums
  end
end
