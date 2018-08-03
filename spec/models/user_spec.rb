require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:role) }
    it { should validate_presence_of(:password) }
  end

  describe 'relationships' do
    it { should have_many(:questions) }
    it { should have_many(:answers) }
    it { should have_many(:comments) }
    it { should have_many(:sub_comments) }
  end

  describe 'instance methods' do
    
  end

  describe 'class methods' do
    
  end
end
