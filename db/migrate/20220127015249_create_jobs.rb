class CreateJobs < ActiveRecord::Migration[6.1]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :description
      t.integer :total_vacancies
      t.date :application_date
      t.date :last_application_date
      t.integer :area
      t.integer :location
      t.string :salary
      t.string :external_link

      t.timestamps
    end
  end
end
