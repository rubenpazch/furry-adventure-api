class CreateJobOrganization < ActiveRecord::Migration[6.1]
  def change
    create_table :job_organizations do |t|
      t.string :title
      t.string :location
      t.string :logo

      t.timestamps
    end
  end
end
