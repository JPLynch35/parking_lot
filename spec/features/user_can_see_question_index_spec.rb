require 'rails_helper'

describe 'user visits questions index page' do
  context 'as an unregistered visitor' do
    before :each do
      user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'bobby')
      @question1 = user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = user1.questions.create(content: 'How do you win a pizza eating contest?')
    end
    it 'can see a list of all the parking lot questions' do
      visit questions_path

      expect(page).to have_content('Parking Lot')
      expect(page).to have_content(@question1.content)
      expect(page).to have_content(@question2.content)
    end
    it 'cannot post a question' do
      visit questions_path

      expect(page).to_not have_button('Post a Question')
    end
  end

  context 'logged in as as a default user' do
    before :each do
      user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret')
      @question1 = user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = user1.questions.create(content: 'How do you win a pizza eating contest?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user2)
    end
    it 'can see a list of all the parking lot questions' do
      visit questions_path

      expect(page).to have_content('Parking Lot')
      expect(page).to have_content(@question1.content)
      expect(page).to have_content(@question2.content)
    end
    it 'can post a question' do
      visit questions_path
      click_on 'Post a Question'

      expect(current_path).to eq(new_question_path)

      fill_in 'content', with: 'This is a test question, can you see it?'
      click_on 'Submit'

      expect(current_path).to eq(question_path(Question.last))
      expect(page).to have_content('This is a test question, can you see it?')
      expect(page).to have_content('Submitted by: Bob S.')
    end
  end
end
