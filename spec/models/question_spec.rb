require 'rails_helper'

describe Question, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_one(:answer) }
    it { should have_many(:comments) }
    it { should have_many(:sub_comments).through(:comments) }
  end
end
