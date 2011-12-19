class CreateMemberships < ActiveRecord::Migration
  def self.up
    create_table :memberships do |t|
      t.integer :user_id
      t.integer :account_id
      t.boolean :owner

      t.timestamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :account_id
    add_index :memberships, [:user_id, :account_id], :unique => true
  end

  def self.down
    drop_table :memberships
  end
end
