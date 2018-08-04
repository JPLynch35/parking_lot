require 'rails_helper'

describe 'user visits root page' do
  context 'as an unregister visitor' do
    it 'can see links to log in and register an account' do
      visit '/'

      within('nav') do
        expect(page).to have_content('Log In')
        expect(page).to have_content('Register')
        expect(page).to_not have_content('Logged in as:')
      end
    end
    it 'can no longer see log in or register when logged in' do
      user = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      visit '/'
      click_on 'Log In'
      fill_in 'email', with: user.email
      fill_in 'password', with: user.password
      click_on 'Submit'

      within('nav') do
        expect(page).to_not have_content('Log In')
        expect(page).to_not have_content('Register')
        expect(page).to have_content('Log Out')
        expect(page).to have_content('Logged in as:')
      end
    end
    it 'can return to questions index by clicking on ParkingLot' do
      visit '/'
      click_on 'Register'

      expect(current_path).to eq(new_user_path)

      click_on 'ParkingLot'

      expect(current_path).to eq(questions_path)
    end
  end
end
