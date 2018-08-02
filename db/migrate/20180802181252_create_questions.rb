class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :status
      t.references :user
      t.references :answer
      t.references :comment, foreign_key: true
    end
  end
end
