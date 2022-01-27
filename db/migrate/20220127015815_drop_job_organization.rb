class DropJobOrganization < ActiveRecord::Migration[6.1]
  def change
    drop_table :job_organizations
  end
end
