class CreateResponseTimes < ActiveRecord::Migration
  def change
    add_column :sites, :response_times, :text
  end
end
