require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    describe 'Saving Entry' do
      it "return true when saved correctly''" do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: '200', quantity: 2, category: @category)
        expect(@product).to be_valid
      end
    end

    describe 'Product model validations' do
      it 'returns true when given name is nil' do
        @category = Category.create
        @product = Product.create(price: '200', quantity: 2, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Name can't be blank")
      end

      it 'returns true when given price is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', quantity: 2, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Price can't be blank")
      end
      
      it 'returns true when given quantity is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: 200, category: @category)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Quantity can't be blank")
      end

      it 'returns true when given category is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: 200, quantity: 3)
        expect(@product).to_not be_valid
        expect(@product.errors.full_messages).to include("Category can't be blank")
      end
    end

  end
end
