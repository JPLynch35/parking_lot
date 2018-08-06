class Question < ApplicationRecord
  validates_presence_of :content, :user_id

  belongs_to :user
  has_one :answer, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :sub_comments, through: :comments
end
