require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:test_user) { User.new(name: "first last", username: "test_user", email: "email@test.com", password: "password123!") }
  
  it "is valid with valid attributes" do
    expect(test_user.valid?).to be true
  end

  it "is not valid without a username" do
    test_user.username = nil
    expect(test_user.valid?).to be false
  end

  it "is not valid without a email" do
    test_user.email = nil
    expect(test_user.valid?).to be false
  end

  it "is not valid without a valid email" do
    test_user.email = "bad_email-test.com"
    expect(test_user.valid?).to be false
  end

  it "is not valid without a password" do
    test_user.password = nil
    expect(test_user.valid?).to be false
  end
end