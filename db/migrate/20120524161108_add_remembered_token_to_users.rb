class AddRememberedTokenToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :remembered_token, :string
  	add_index :users, :remembered_token
  end
end
