class AddJobOrganizationToJob < ActiveRecord::Migration[6.1]
  def change
    add_reference :jobs, :job_organization, null: false, foreign_key: true
  end
end
