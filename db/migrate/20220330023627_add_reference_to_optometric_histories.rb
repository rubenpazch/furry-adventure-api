# frozen_string_literal: true

class AddReferenceToOptometricHistories < ActiveRecord::Migration[7.0]
  def change
    add_reference :optometric_histories, :people, null: false, foreign_key: true
  end
end
