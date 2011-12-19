class AddDomainIdToEvents < ActiveRecord::Migration
  def self.up
    add_column :events, :domain_id, :integer
  end

  def self.down
    remove_column :events, :domain_id
  end
end
