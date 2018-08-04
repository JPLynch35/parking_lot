require 'rails_helper'

describe SubComment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:comment_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:comment) }
  end
end
