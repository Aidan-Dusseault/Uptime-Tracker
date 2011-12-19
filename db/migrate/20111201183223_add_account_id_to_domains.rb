class AddAccountIdToDomains < ActiveRecord::Migration
  def self.up
    add_column :domains, :account_id, :integer
  end

  def self.down
    remove_column :domains, :account_id
  end
end
