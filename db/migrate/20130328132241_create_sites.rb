class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :url
      t.string :state, :default => "unknown"
      t.string :message, :default => ""

      t.datetime :ok_at
      t.datetime :failed_at
      t.integer :user_id

      t.timestamps
    end
  end
end
