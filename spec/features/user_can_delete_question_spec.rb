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
    it 'can successfully delete their own questions' do
      visit question_path(@question1)
      click_on 'Delete'

      expect(current_path).to eq(questions_path)
      expect(page).to_not have_content(@question1.content)
    end
  end

  context 'logged in as as an admin user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin1 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @question2 = @user1.questions.create(content: 'How do you win a pizza eating contest?')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'can successfully delete any question' do
      visit admin_question_path(@question1)
      within('.button-margin') do
        click_on('Delete')
      end

      expect(current_path).to eq(questions_path)
      expect(page).to_not have_content(@question1.content)

      visit admin_question_path(@question2)
      within('.button-margin') do
        click_on('Delete')
      end

      expect(current_path).to eq(questions_path)
      expect(page).to_not have_content(@question2.content)
    end
    it 'can delete question even after it has been answered' do
      @admin1.answers.create(content: 'By running.', question_id: @question1.id)

      visit admin_question_path(@question1)

      within('.button-margin') do
        click_on('Delete')
      end

      expect(current_path).to eq(questions_path)
      expect(page).to_not have_content('How do people train for a marathon?')
    end
  end
end
