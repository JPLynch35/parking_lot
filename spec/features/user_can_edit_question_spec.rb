require 'rails_helper'

describe 'user visits question edit page' do
  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
      @question3 = @user2.questions.create(content: 'How do you make millions of dollars?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end
    it 'can successfully edit their own question' do
      visit edit_question_path(@question1)
      fill_in :question_content, with: 'How do people like to run for over 20 miles?'
      click_on 'Submit'

      expect(current_path).to eq(question_path(@question1))
      expect(page).to have_content('How do people like to run for over 20 miles?')
    end
    it 'can unsuccessfully edit their own question if missing required field' do
      visit edit_question_path(@question1)
      fill_in :question_content, with: ''
      click_on 'Submit'

      expect(Question.first.content).to eq('How do people train for a marathon?')
    end
    it 'cannot edit question after it has been answered' do
      admin1 = User.create(email: 'Jane@gmail.com', first_name: 'Jane', last_name: 'Smith', password: 'secret', role: 1)
      Answer.create(content: 'By running', question_id: @question1.id, user_id: admin1.id)
      visit question_path(@question1)

      expect(page).to_not have_link('Edit')
    end
  end
end
