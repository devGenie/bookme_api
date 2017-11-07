require 'rails_helper'
require 'coveralls'
Coveralls.wear!

RSpec.describe User, type: :model do
  subject { described_class.new(first_name:"Onen",
                                last_name:"Julius",
                                email:"jonen54@gmail.com",
                                password:"256thjuly",
                                date_added:Time.now(),
                                created_at:Time.now(),
                                updated_at:Time.now())
                               }
  it "has a valid factory" do
    FactoryBot.create(:user).should be_valid
  end

  it "is valid with valid attributes" do
    user = FactoryBot.create(:user)
    expect(user).to be_valid
  end

  it "is not valid without an email" do 
    subject.email=nil
    expect(subject).to_not be_valid
  end

  it "is not valid with missing attributes" do
    subject.first_name =nil
    expect(subject).to_not be_valid
  end
  
  it "is not valid if duplicate" do
    original_user = FactoryBot.create(:user)
    duplicate = subject
    expect(duplicate).to_not be_valid
  end
end
