require 'rails_helper'

describe 'user visits admin question show page' do
  context 'logged in as as an admin' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin1 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @answer1 = @question1.answer.create(content: 'By running')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'can delete an answer' do
      visit admin_question_path(@question1)
      within () do
        click_on 'Delete'
      end

      expect(current_path).to eq(questions_index)
    end
  end
end
