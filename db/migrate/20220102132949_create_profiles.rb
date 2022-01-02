class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles, id: :uuid do |t|
      t.string :name

      t.timestamps
    end
  end
end
