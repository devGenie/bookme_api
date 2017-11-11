class User < ApplicationRecord
    has_secure_password
    has_secure_token
    has_many :subscriptions, dependent: :destroy
    has_many :authentications, dependent: :destroy
    validates_presence_of :first_name, :last_name, :email, :password_digest
    validates_uniqueness_of :email
end
