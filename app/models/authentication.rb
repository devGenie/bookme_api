require 'securerandom'

class Authentication < ApplicationRecord
    has_secure_token

    private
    def set_auth_token
        self.token = generate_auth_token
    end

    def generate_auth_token
        SecureRandom.uuid.gsub(/\-/,'')
    end
end
