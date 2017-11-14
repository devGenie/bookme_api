class User < ApplicationRecord
    before_save :downcase_email
    has_secure_password
    has_many :subscriptions, dependent: :destroy
    has_many :blacklisted_tokens, dependent: :destroy
    validates_presence_of :first_name, :last_name, :email, :password_digest
    validates_uniqueness_of :email
    validates_format_of :email, with: /@/ 

    def downcase_email
        self.email = self.email.delete(' ').downcase
    end
end
