class AddPlanIdToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :planid, :string
    add_column :users, :subscribed, :boolean, :default => false
    add_column :users, :stripeid, :string
  end
end
