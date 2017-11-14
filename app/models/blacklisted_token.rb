require 'securerandom'

class BlacklistedToken < ApplicationRecord
    validates_uniqueness_of :token
end
