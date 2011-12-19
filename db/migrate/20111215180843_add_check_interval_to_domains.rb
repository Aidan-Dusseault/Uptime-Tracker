class AddCheckIntervalToDomains < ActiveRecord::Migration
  def self.up
    add_column :domains, :check_interval, :integer
  end

  def self.down
    remove_column :domains, :check_interval
  end
end
