class AddLastCheckedToDomains < ActiveRecord::Migration
  def self.up
    add_column :domains, :last_checked, :timestamp
  end

  def self.down
    remove_column :domains, :last_checked
  end
end
