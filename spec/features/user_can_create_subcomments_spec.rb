require 'rails_helper'

describe 'user visits question show page' do
  context 'as an unregistered visitor' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question1.id)
    end
    it 'cannot post a subcomment' do
      visit question_path(@question1)

      expect(page).to_not have_button('Post a Sub-Comment')

      visit new_question_comment_sub_comment_path(@question1, @comment)
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  context 'logged in as as a default user' do
    before :each do
      @user1 = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @user2 = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Toner', password: 'doublesecret')
      @question1 = @user1.questions.create(content: 'How do people train for a marathon?')
      @comment = @user2.comments.create(content: 'Great Question!', question_id: @question1.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user1)
    end
    it 'can successfully navigate to post a subcomment' do
      visit question_path(@question1)

      within("#comment-#{@comment.id}") do
        click_on('Post a Sub-Comment')
      end

      expect(current_path).to eq(new_question_comment_sub_comment_path(@question1, @comment))
    end
    it 'can successfully post a subcomment' do
      visit new_question_comment_sub_comment_path(@question1, @comment)

      fill_in :sub_comment_content, with: 'Great info!'
      click_on('Create Sub-Comment')

      expect(current_path).to eq(question_path(@question1))
      expect(page).to have_content('Great info!')
    end
  end

  context 'logged in as as an admin' do
    before :each do
      @user = User.create(email: 'Bob@gmail.com', first_name: 'Bob', last_name: 'Smith', password: 'secret')
      @admin = User.create(email: 'Jill@gmail.com', first_name: 'Jill', last_name: 'Smith', password: 'secret', role: 1)
      @question = @user.questions.create(content: 'How do people train for a marathon?')
      @comment = @user.comments.create(content: 'Great Question!', question_id: @question.id)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    end
    it 'can successfully navigate to post a sub-comment' do
      visit admin_question_path(@question)

      expect(page).to have_button('Post a Sub-Comment')

      click_on('Post a Sub-Comment')

      expect(current_path).to eq(new_admin_question_comment_sub_comment_path(@question, @comment))
    end
    it 'can successfully post a sub-comment' do
      visit new_admin_question_comment_sub_comment_path(@question, @comment)

      fill_in :sub_comment_content, with: 'Can you please clarify?'
      click_on 'Create Sub-Comment'

      expect(current_path).to eq(admin_question_path(@question))
      expect(page).to have_content('Can you please clarify?')
      expect(page).to have_content('Jill S.')
    end
  end
end
