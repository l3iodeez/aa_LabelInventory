class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :track_id, null: false
      t.integer :user_id, null: false
      t.text :note_text
    end

    add_index :notes, :track_id
    add_foreign_key :notes, :tracks
    add_index :notes, :user_id
    add_foreign_key :notes, :users
  end
end
