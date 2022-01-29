class ChangeLocationToBeStringInJobs < ActiveRecord::Migration[6.1]
  def change
    change_column :jobs, :location, :string
  end
end
