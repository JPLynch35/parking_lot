require 'rails_helper'

describe 'user visits question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question.id)
      @sub_comment = @user1.sub_comments.create(content: 'Great Comment!', comment_id: @comment.id)
    end
    it 'cannot edit a subcomment' do
      visit question_path(@question)

      expect(page).to_not have_link('Edit')

      visit edit_question_comment_sub_comment_path(@question, @comment, @sub_comment)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question.id)
      @sub_comment1 = @user1.sub_comments.create(content: 'Great Comment!', comment_id: @comment.id)
      @sub_comment2 = @user2.sub_comments.create(content: 'Thanks!', comment_id: @comment.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
    end
    it 'can successfully navigate to edit their own comment' do
      visit question_path(@question)

      within("#sub_comment-#{@sub_comment1.id}") do
        expect(page).to_not have_link('Edit')
      end

      within("#sub_comment-#{@sub_comment2.id}") do
        click_on('Edit')
      end

      expect(current_path).to eq(edit_question_comment_sub_comment_path(@question, @comment, @sub_comment2))
    end
    it 'can successfully edit their own subcomment' do
      visit edit_question_comment_sub_comment_path(@question, @comment, @sub_comment2)

      fill_in :sub_comment_content, with: 'Slightly bad comment.'
      click_on 'Create a Sub-Comment'

      expect(current_path).to eq(question_path(@question))
      within("#sub_comment-#{@sub_comment2.id}") do
        expect(page).to have_content('Slightly bad comment.')
      end
    end
  end

  context 'logged in as as an admin' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @admin1 = User.create(email: 'Jack@gmail.com', first_name: 'Jack', last_name: 'Blamer', password: 'secret', role: 1)
      @question = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question.id)
      @sub_comment1 = @user1.sub_comments.create(content: 'Great Comment!', comment_id: @comment.id)
      @sub_comment2 = @admin1.sub_comments.create(content: 'Admin subcomment!', comment_id: @comment.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin1)
    end
    it 'can successfully navigate to edit their own subcomment' do
      visit admin_question_path(@question)

      within("#sub_comment-#{@sub_comment1.id}") do
        expect(page).to_not have_link('Edit')
      end

      within("#sub_comment-#{@sub_comment2.id}") do
        click_on('Edit')
      end

      expect(current_path).to eq(edit_admin_question_comment_sub_comment_path(@question, @comment, @sub_comment2))
    end
  #   it 'can successfully edit their own comment' do
  #     visit edit_admin_question_comment_path(@question, @comment2)

  #     fill_in :comment_content, with: 'Almight powerful admin, making a normal comment.'
  #     click_on 'Update Comment'

  #     expect(current_path).to eq(admin_question_path(@question))
  #     within("#comment-#{@comment2.id}") do
  #       expect(page).to have_content('Almight powerful admin, making a normal comment.')
  #     end
  #   end
  end
end
