require 'rails_helper'

describe 'a visitor' do
  describe 'visiting the root page' do
    it 'can click on the log in button and be taken to to login page' do
      visit '/'
      click_on 'Log In'

      expect(current_path).to eq(login_path)
    end
  end
end
