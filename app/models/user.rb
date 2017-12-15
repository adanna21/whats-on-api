class User < ApplicationRecord
  before_save :downcase_email
  has_many :shows, dependent: :delete_all
  has_secure_password
  has_secure_token :auth_token

  validates_uniqueness_of :username, length: { maximum: 50 }
  validates :password,
            length: { minimum: 5 },
            # confirmation: true,
            allow_nil: true
  validates :email,
            presence: true,
            uniqueness: { case_sensative: false },
            format: {
              with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/,
              message: 'Thats not an email!'
            },
            length: {
              minimum: 5
            }
  # validates :password_confirmation,
  #           presence: true,
  #           if: :password_confirmation_required?

  attr_reader :password_confirmation

  def invalidate_token
    update_columns(auth_token: nil)
  end

  # if the user and password match then return user
  def self.validate_login(username, password)
    user = find_by(username: username)
    user if user && user.authenticate(password)
  end

  def downcase_email
    self.email = email.downcase
  end

  # def password_confirmation_required?
  #   new_record? || password_confirmation.present?
  # end
end
