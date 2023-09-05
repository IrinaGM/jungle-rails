require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "is valid with valid attributes" do
      category = Category.new(name: "Shrub")
      product = Product.new(name: "Iris", price: 30, quantity: 10, category: category)
      expect(product).to be_valid
    end

    it "is not valid without a name'" do
      category = Category.new(name: "Shrub")
      product = Product.new(name: nil, price: 30, quantity: 10, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Name can't be blank"]
    end

    it "is not valid without a price" do
      category = Category.new(name: "Shrub")
      product = Product.new(name: "Iris", price: "", quantity: 10, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Price is not a number"]
    end

    it "is not valid without a quantity" do
      category = Category.new(name: "Shrub")
      product = Product.new(name: "Iris", price: 30, quantity: nil, category: category)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Quantity can't be blank"]
    end

    it "is not valid without a category" do
      product = Product.new(name: "Iris", price: 30, quantity: 10, category: nil)
      expect(product).to_not be_valid
      expect(product.errors.full_messages).to eq ["Category must exist", "Category can't be blank"]
    end
  end
end