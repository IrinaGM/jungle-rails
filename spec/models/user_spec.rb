require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    before(:context) do
      @lia = User.create!(first_name: "Lia", last_name: "June", email: "june@example.com", password: "019283", password_confirmation: "019283")
    end

    after(:context) do
      @lia.destroy
    end

    it "is valid with valid attributes" do
      john = User.new(first_name: "John", last_name: "May", email: "john@example.com", password: "1234", password_confirmation: "1234")
      expect(john).to be_valid
    end

    it "is not valid with mismatching passwords" do
      john = User.new(first_name: "John", last_name: "May", email: "john@example.com", password: "1234", password_confirmation: "23")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Password confirmation doesn't match Password"]
    end

    it "is not valid with existing email" do
      john = User.new(first_name: "John", last_name: "May", email: "june@example.com", password: "1234", password_confirmation: "1234")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Email has already been taken"]
    end

    it "is not valid with case sensitive existing email" do
      john = User.new(first_name: "John", last_name: "May", email: "JUNE@example.com", password: "1234", password_confirmation: "1234")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Email has already been taken"]
    end

    it "is not valid without email" do
      john = User.new(first_name: "John", last_name: "May", email: nil, password: "1234", password_confirmation: "1234")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Email can't be blank"]
    end

    it "is not valid without first name" do
      john = User.new(first_name: nil, last_name: "May", email: "john@example.com", password: "1234", password_confirmation: "1234")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["First name can't be blank"]
    end

    it "is not valid without last name" do
      john = User.new(first_name: "John", last_name: nil, email: "john@example.com", password: "1234", password_confirmation: "1234")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Last name can't be blank"]
    end

    it "is not valid with short password" do
      john = User.new(first_name: "John", last_name: "May", email: "john@example.com", password: "123", password_confirmation: "123")
      expect(john).to_not be_valid
      expect(john.errors.full_messages).to eq ["Password is too short (minimum is 4 characters)"]
    end

  end

  describe '.authenticate_with_credentials' do
    before(:context) do
      @lia = User.create!(first_name: "Lia", last_name: "June", email: "june@example.com", password: "019283", password_confirmation: "019283")
    end

    after(:context) do
      @lia.destroy
    end

    it "returns the same user if valid attributes were provided" do
      user = User.authenticate_with_credentials(@lia.email, @lia.password)
      expect(user).to eql @lia
    end

    it "returns the same user if valid email with spaces was provided" do
      user = User.authenticate_with_credentials("   #{@lia.email}   ", @lia.password)
      expect(user).to eql @lia
    end

    it "returns the same user if valid email with wrong case was provided" do
      user = User.authenticate_with_credentials(@lia.email.upcase, @lia.password)
      expect(user).to eql @lia
    end

    it "returns nil if invalid email was provided" do
      user = User.authenticate_with_credentials("july@example.com", @lia.password)
      expect(user).to be_nil
    end

    it "returns nil if invalid password was provided" do
      user = User.authenticate_with_credentials(@lia.email, "129075")
      expect(user).to be_nil
    end

  end
end
