require 'rails_helper'

describe Answer, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'relationships' do
    it { should belong_to(:user) }
    it { should belong_to(:question) }
  end
end
