require 'rails_helper'

describe 'user visits root page' do
  context 'as an unregistered visitor' do
    it 'can create an account' do
      visit '/'
      within('nav') do
        click_on 'Register'
      end

      expect(current_path).to eq(new_user_path)

      fill_in 'user_email', with: 'Jeff@gmail.com'
      fill_in 'user_first_name', with: 'Jeff'
      fill_in 'user_last_name', with: 'Smith'
      fill_in 'user_password', with: 'secret'
      click_on 'Create Account'

      expect(current_path).to eq(questions_path)
      expect(User.last.first_name).to eq('Jeff')
    end
  end

  context 'as a registered user' do
    it 'can log in to existing account' do
      user = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')

      visit '/'
      within('nav') do
        click_on 'Log In'
      end

      expect(current_path).to eq(login_path)

      fill_in 'email', with: 'Bob@gmail.com'
      fill_in 'password', with: 'secret'
      click_on 'Submit'

      expect(current_path).to eq(questions_path)

      click_on 'Log Out'

      within('nav') do
        expect(page).to have_content('Log In')
      end

      expect(current_path).to eq(questions_path)
    end
  end
end
