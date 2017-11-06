class User < ApplicationRecord
    validates_presence_of :first_name, :last_name, :email, :password
    validates_uniqueness_of :email
end
