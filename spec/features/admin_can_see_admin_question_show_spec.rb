require 'rails_helper'

describe 'user visits admin question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'bobby')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
    end
    it 'sees a 404 page' do
      visit admin_question_path(@question1)

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end
    it 'sees a 404 page' do
      visit admin_question_path(@question1)

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'logged in as as an admin' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin1 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'sees the question' do
      visit admin_question_path(@question1)

      expect(page).to have_content(@question1.content)
    end
    it 'can answer the question' do
      visit admin_question_path(@question1)

      fill_in 'Content', with: 'This is a test answer, can you see it?'
      click_on 'Submit'

      expect(current_path).to eq(admin_question_path(@question1))
      expect(page).to have_content('This is a test answer, can you see it?')
    end
  end
end
