require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new }
  it "has a valid factory" do
    FactoryBot.create(:user).should be_valid
  end

  it "is valid with valid attributes" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "is not valid without a name" do 
    subject.first_name=nil
    expect(subject).to_not be_valid
  end

  it "is not valid with missing attributes" do
    subject.first_name ="Onen"
    expect(subject).to_not be_valid
  end
  
  it "is not valid if duplicate" do
    original_user = FactoryBot.create(:user)
    duplicate = FactoryBot.create(:user)
    expect(duplicate).to_not be_valid
  end
end
