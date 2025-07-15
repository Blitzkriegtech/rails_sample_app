class User < ApplicationRecord
    attr_accessor :remember_token

    before_save :downcase_email
    has_secure_password

    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    validates :name, presence: true, length: { maximum: 50 }

    # email validator
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }

    # Returns the hash digest of the given string.
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                      BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end

    # Returns a random token.
    def User.new_token
      SecureRandom.urlsafe_base64
    end

    # remembers a user in the database for use in persistent sessions.
    def remember
      self.remember_token = User.new_token
      update_attribute(:remember_digest, User.digest(remember_token))
      remember_digest
    end

    # returns true if the given token matches the digest.
    def authenticated?(remember_token)
      return false if remember_digest.nil?
      BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end

    # forgets a user.
    def forget
      update_attribute(:remember_digest, nil)
    end

    # returns a session token to prevent session hijacking.
    # reuse the remember digest for convenience.
    def session_token
      remember_digest || remember
    end

    private

    def downcase_email
      email.downcase!
    end
end
