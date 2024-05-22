require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe 'Validations' do
    before(:each) do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
      )
  end
end

  describe ' .authenticate_with_credentials' do
    before(:each) do
      @user = User.create(
        email: 'test@example.com',
        password: 'password',
        password_confirmation: 'password',
      )
    end

    it 'authenticates with correct email and password' do
      user = User.authenticate_with_credentials('test@example.com', 'password')
      expect(user).to eq(@user)
    end

    it 'does not authenticate with incorrect email and password' do
      user = User.authenticate_with_credentials('test@example.com', 'wrongpassword')
      expect(user).to be_nil
    end

    it 'authenticates with email in different case' do
      user = User.authenticate_with_credentials('TEST@example.com', 'password')
      expect(user).to eq(@user)
    end

    it 'authenticates with email having leading/trailing spaces' do
      user = User.authenticate_with_credentials('  test@example.com  ', 'password')
      expect(user).to eq(@user)
    end

    it 'does not authenticate with non-existing email' do
      user = User.authenticate_with_credentials('nonexistent@example.com', 'password')
      expect(user).to be_nil
    end

    it 'is not valid with a non-unique email (case insensitive)' do
      @user.save
      another_user = User.new(
        email: 'TEST@example.com',
        password: 'password',
        password_confirmation: 'password',
      )
      expect(another_user).not_to be_valid
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'is not valid with a password shorter than 6 characters' do
      @user.password = 'short'
      @user.password_confirmation = 'short'
      expect(@user).not_to be_valid
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end
  end
end
