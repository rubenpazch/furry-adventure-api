require "rails_helper"

RSpec.describe Products::Category, type: :model do
  let(:valid_category) { build :products_category }

  context "Valid category" do
    it "with slug to be equal compared with title" do
      expect(valid_category).to be_valid
      valid_category.save!
    end
  end

  context "Invalid category" do 
    it "with slug to be different compared with title" do
      array_items = valid_category.title.split(' ')
      array_items[2]='test'
      valid_category.title = array_items.join('-')
      expect(valid_category).to be_invalid
    end
  end
end
