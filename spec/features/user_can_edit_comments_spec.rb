require 'rails_helper'

describe 'user visits question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question1.id)
    end
    it 'cannot edit a comment' do
      visit question_path(@question1)

      expect(page).to_not have_link('Edit')

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
    it 'can successfully navigate to edit their own comment' do
      visit question_path(@question1)

      within('#comment-1') do
        expect(page).to_not have_link('Edit')
      end

      within('#comment-2') do
        expect(page).to have_link('Edit')

        click_on('Edit')
      end

      expect(current_path).to eq(edit_question_comment_path(@question1, @comment2))
    end
    it 'can successfully edit their own comment' do
      visit edit_question_comment_path(@question1, @comment2)

      fill_in :comment_content, with: 'Slightly bad question.'
      click_on 'Update Comment'

      expect(current_path).to eq(question_path(@question1))
      within('#comment-2') do
        expect(page).to have_content('Slightly bad question.')
      end
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
    it 'can successfully navigate to edit their own comment' do
      visit question_path(@question1)

      within('#comment-1') do
        expect(page).to_not have_link('Edit')
      end

      within('#comment-2') do
        expect(page).to have_link('Edit')

        click_on('Edit')
      end

      expect(current_path).to eq(edit_question_comment_path(@question1, @comment2))
    end
    it 'can successfully edit their own comment' do
      visit edit_question_comment_path(@question1, @comment2)

      fill_in :comment_content, with: 'Almight powerful admin, making a normal comment.'
      click_on 'Update Comment'

      expect(current_path).to eq(question_path(@question1))
      within('#comment-2') do
        expect(page).to have_content('Almight powerful admin, making a normal comment.')
      end
    end
  end
end
