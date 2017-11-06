require 'rails_helper'

RSpec.describe User, type: :model do
  it "has a valid factory" do
    FactoryBot.create(:user).should be_valid
  end

  it "is valid with valid attributes" do
    expect(User.new(first_name:"Onen")).to be_valid
  end

  it "is not valid without a name" do 
    user = User.new(first_name:nil)
    expect(user).to_not be_valid
  end
end
