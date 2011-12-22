class AddDefaultValueToDomains < ActiveRecord::Migration
  def self.up
    change_column :domains, :last_checked, :time, :default => Time.at(0).utc, :null => false 
  end

  def self.down
    change_column :domains, :last_checked, :time, :default => nil, :null => true
  end
end
