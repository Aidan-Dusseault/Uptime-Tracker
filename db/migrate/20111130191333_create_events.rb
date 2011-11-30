class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|

      t.timestamps
      t.integer :status_change
    end
  end

  def self.down
    drop_table :events
  end
end
