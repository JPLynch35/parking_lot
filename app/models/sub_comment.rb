class SubComment < ApplicationRecord
  validates_presence_of :content, :user_id, :comment_id

  belongs_to :user
  belongs_to :comment
end
