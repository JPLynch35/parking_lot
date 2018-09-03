require 'rails_helper'

describe 'user visits question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question1.id)
    end
    it 'cannot delete a comment' do
      visit question_path(@question1)

      expect(page).to_not have_link('Delete')

      visit edit_question_comment_path(@question1, @comment)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment1 = @user1.comments.create(content: 'Great Question!', question_id: @question1.id)
      @comment2 = @user2.comments.create(content: 'Terrible Question!', question_id: @question1.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
    end
    it 'can successfully delete their own comment' do
      visit question_path(@question1)

      within('#comment-1') do
        expect(page).to_not have_link('Delete')
      end

      within('#comment-2') do
        expect(page).to have_link('Delete')

        click_on('Delete')
      end

      expect(current_path).to eq(question_path(@question1))
      expect(page).to_not have_content('Terrible Question!')
    end
  end

  context 'logged in as as an admin' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin1 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment1 = @user1.comments.create(content: 'Great Question!', question_id: @question1.id)
      @comment2 = @admin1.comments.create(content: 'This is my admin comment.', question_id: @question1.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'can successfully delete their own comment' do
      visit admin_question_path(@question1)

      within('#comment-1') do
        expect(page).to_not have_link('Delete')
      end

      within('#comment-2') do
        expect(page).to have_link('Delete')

        click_on('Delete')
      end

      expect(current_path).to eq(question_path(@question1))
      expect(page).to_not have_content('This is my admin comment.')
    end
  end
end
