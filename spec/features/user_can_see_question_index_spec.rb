require 'rails_helper'

describe 'a default user' do
  describe 'visiting the questions index page' do
    before :each do
      user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret')
      @question1 = user1.questions.create(content: 'How do people train for a marathon?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
    end
    xit 'can see a list of all the parking lot questions' do
      visit questions_path

      expect(page).to have_content('Parking Lot')
      expect(page).to have_content(@question1.content)
    end
  end
end
