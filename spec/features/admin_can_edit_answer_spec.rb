require 'rails_helper'

describe 'user visits admin question show page' do
  context 'logged in as as an admin' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin1 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @answer1 = Answer.create(content: 'By running', question_id: @question1.id, user_id: @admin1.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'can edit an answer' do
      visit admin_question_path(@question1)
      within('#answer') do
        click_on 'Edit'
      end

      fill_in :content, with: 'This is an edited answer'
      expect(current_path).to eq(admin_question_path(@question1))
      expect(page).to have_content('This is an edited answer')
    end
  end
end
