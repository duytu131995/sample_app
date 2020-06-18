class User < ApplicationRecord
  before_save :downcase_email

  VALID_EMAIL_REGEX = Settings.email_regex
  USER_PARAMS = %i(name email password password_confirmation).freeze

  validates :name, presence: true,
            length: {maximum: Settings.user.name.maximum_length}
  validates :email, presence: true,
            length: {maximum: Settings.user.email.maximum_length},
            format: {with: VALID_EMAIL_REGEX},
            uniqueness: true

  has_secure_password

  private

  def downcase_email
    email.downcase!
  end
end
