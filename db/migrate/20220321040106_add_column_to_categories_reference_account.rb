class AddColumnToCategoriesReferenceAccount < ActiveRecord::Migration[7.0]
  def change
    add_reference :product_categories, :account, null: false, foreign_key: true
  end
end
