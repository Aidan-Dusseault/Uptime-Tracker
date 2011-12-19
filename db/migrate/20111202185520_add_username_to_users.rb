class AddUsernameToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :username, :string
    add_index :users, :username, :unique => true
    remove_index :users, :name
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration, "Removing the uniquess index for users is irreversible."
  end
end
