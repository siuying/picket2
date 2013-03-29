class AddSiteTime < ActiveRecord::Migration
  def change
    add_column :sites, :last_response_time, :float
  end
end
