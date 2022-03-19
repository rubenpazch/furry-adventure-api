class CreateAccount < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :location
      t.string :address
      t.belongs_to :organizations, foreign_key: true

      t.timestamps
    end
  end
end
