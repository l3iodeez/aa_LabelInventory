class AddIndicesToUsers < ActiveRecord::Migration
  def change
    remove_index :users, column: :email
    add_index :users, :session_token, unique: true
    add_index :users, :email, unique: true
  end
end
