require 'rails_helper'

describe Comment, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:question_id) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:question) }
    it { should have_many(:sub_comments) }
  end
end
