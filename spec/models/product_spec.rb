require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do

    describe 'Saving Entry' do
      it "return true when saved correctly''" do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: '200', quantity: 2, category: @category)
        expect(@product).to be_present
      end
    end

    describe 'Product model validations' do
      it 'returns true when given name is nil' do
        @category = Category.create
        @product = Product.create(name: nil)
        expect(@product.name).to be_nil
      end

      it 'returns true when given price is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', quantity: 2, category: @category)
        expect(@product.price).to be_nil
      end
      
      it 'returns true when given quantity is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: 200, category: @category)
        expect(@product.quantity).to be_nil
      end

      it 'returns true when given category is nil' do
        @category = Category.create
        @product = Product.create(name: 'Phil', price: 200, quantity: 3)
        expect(@product.category).to be_nil
      end
    end

  end
end
