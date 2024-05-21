require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
    before(:each) do
      @category = Category.create(name: 'Test Category')
    end

  it 'saves when all fields are set' do
    product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: @category)
    expect(product).to be_valid
    expect(product.save).to eq(true)
  end

  it 'is not valid without a name' do 
    product = Product.new(name: nil, price: 100, quantity: 10, category: @category)
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Name can't be blank")
  end

  it 'is not valid without a price' do
    product = Product.new(name: 'Test Product', price: nil, quantity: 10, category: @category)
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Price is not a number")
  end

  it 'is not valid with a price of 0' do
    product = Product.new(name: 'Test Product', price: 0, quantity: 10, category: @category)
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Price must be greater than 0")
  end

  it 'is not valid without a quantity' do
    product = Product.new(name: 'Test Product', price: 100, quantity: nil, category: @category)
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Quantity can't be blank")
  end

  it 'is not valid without a category' do
    product = Product.new(name: 'Test Product', price: 100, quantity: 10, category: nil)
    expect(product).not_to be_valid
    expect(product.errors.full_messages).to include("Category can't be blank")
  end

  end
end
