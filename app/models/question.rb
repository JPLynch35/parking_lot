class Question < ApplicationRecord
  validates_presence_of :content, :status, :user_id

  belongs_to :user
  has_one :answer
  has_many :comments
  has_many :sub_comments, through: :comments
end
