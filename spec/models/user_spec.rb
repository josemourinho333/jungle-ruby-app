require 'rails_helper'

RSpec.describe User, type: :model do
  describe "user validations" do

    describe 'Saving user' do
      it 'should return true and valid when creating user' do
        @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
        expect(@user).to be_valid
      end
    end

    describe 'Registration field validation' do
      it 'should return true when passwords do not match' do
        @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '321')
        expect(@user).to_not be_valid
      end

      it 'should return true when email is not entered' do
        @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: '', password: '123', password_confirmation: '123')
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end

      it 'should return true when first name is not entered' do
        @user = User.create(first_name: '', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("First name can't be blank")
      end

      it 'should return true when last name is not entered' do
        @user = User.create(first_name: 'Phil', last_name: '', email: 'test@test.com', password: '123', password_confirmation: '123')
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include("Last name can't be blank")
      end
    end

    describe "Uniqueness of an email" do
      it "should return true when case insensitive email exists" do
        @userOG = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'TEST@test.com', password: '123', password_confirmation: '123')

        @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include('Email has already been taken')
      end
    end

    describe "Password min length" do
      it "should return true when password is less than 3 in length" do
        @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '12', password_confirmation: '12')
        expect(@user).to_not be_valid
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 3 characters)')
      end
    end

  end

  describe ".authenticate_with_credentials" do
    it "should return nil" do
      @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
      user = User.authenticate_with_credentials('test333@test.com', '123')
      expect(user).to be_nil
    end

    it "should return user" do
      @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
      user = User.authenticate_with_credentials('test@test.com', '123')
      expect(user).to be_present
    end

    it "should return user even with white spaces" do
      @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
      user = User.authenticate_with_credentials(' test@test.com ', '123')
      expect(user).to be_present
    end
    
    it "should return user even with diffeerent cases" do
      @user = User.create(first_name: 'Phil', last_name: 'Yoo', email: 'test@test.com', password: '123', password_confirmation: '123')
      user = User.authenticate_with_credentials(' tEsT@test.com ', '123')
      expect(user).to be_present
    end

  end


end
