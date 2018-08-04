class User < ApplicationRecord
  validates_presence_of :first_name, :last_name, :role
  validates :email, uniqueness: true, presence: true
  validates :password, presence: true, length: { minimum: 4 }, allow_nil: true

  has_many :questions
  has_many :answers
  has_many :comments
  has_many :sub_comments

  enum role: ['default', 'admin']

  has_secure_password
  
end
