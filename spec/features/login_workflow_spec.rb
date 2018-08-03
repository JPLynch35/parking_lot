require 'rails_helper'

describe 'a visitor' do
  describe 'visiting the root page' do
    it 'can click on the log in button and be taken to to login page' do
      visit '/'
      click_on 'Log In'

      expect(current_path).to eq(login_path)
    end
    it 'can create an account' do
      visit '/'
      click_on 'Register'

      expect(current_path).to eq(new_user_path)

      fill_in 'user_email', with: 'Jeff@gmail.com'
      fill_in 'user_first_name', with: 'Jeff'
      fill_in 'user_last_name', with: 'Smith'
      fill_in 'user_password', with: 'secret'
      click_on 'Create Account'

      expect(current_path).to eq(questions_path)
      expect(current_user).to eq(User.last)
    end
    # it 'can log in to existing account' do
    #   visit '/'
    #   click_on 'Log In'

    #   expect(current_path).to eq(login_path)
    # end
  end
end
