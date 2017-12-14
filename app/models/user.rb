class User < ApplicationRecord
  validates_uniqness_of :username
  has_secure_password
  has_many :shows, dependent: :delete_all
end
