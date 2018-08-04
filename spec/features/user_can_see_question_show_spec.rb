require 'rails_helper'

describe 'user visits question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'bobby')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
    end
    it 'can see the question' do
      visit question_path(@question1)

      expect(page).to have_content(@question1.content)
      expect(page).to_not have_content(@question2.content)
    end
    it 'cannot see edit buttons for any questions' do
      visit question_path(@question1)

      expect(page).to_not have_button('Edit')

      visit question_path(@question2)

      expect(page).to_not have_button('Edit')
    end
    it 'cannot see delete buttons for any questions' do
      visit question_path(@question1)

      expect(page).to_not have_button('Delete')

      visit question_path(@question2)

      expect(page).to_not have_button('Delete')
    end
  end

  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
      @question3 = @user2.questions.create(content: 'How do you make millions of dollars?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end
    it 'can see the question' do
      visit question_path(@question1)

      expect(page).to have_content(@question1.content)
      expect(page).to_not have_content(@question2.content)
    end
    it 'can see edit buttons only for questions user made' do
      visit question_path(@question1)

      expect(page).to have_button('Edit')

      visit question_path(@question2)

      expect(page).to have_button('Edit')

      visit question_path(@question3)

      expect(page).to_not have_button('Edit')
    end
    it 'can see delete buttons only for questions user made' do
      visit question_path(@question1)

      expect(page).to have_button('Delete')

      visit question_path(@question2)

      expect(page).to have_button('Delete')

      visit question_path(@question3)

      expect(page).to_not have_button('Delete')
    end
  end
end