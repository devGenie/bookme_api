class User < ApplicationRecord
    has_many :subscriptions, dependent: :destroy
    validates_presence_of :first_name, :last_name, :email, :password
    validates_uniqueness_of :email
end
