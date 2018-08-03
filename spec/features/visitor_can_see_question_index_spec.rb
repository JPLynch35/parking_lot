require 'rails_helper'

describe 'a visitor' do
  describe 'visiting the questions index page' do
    before :each do
      user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'bobby')
      @question1 = user1.questions.create(content: 'How do people train for a marathon?')
    end
    it 'can see a list of all the parking lot questions' do
      visit questions_path

      expect(page).to have_content('Parking Lot')
      expect(page).to have_content(@question1.content)
    end
  end
end
