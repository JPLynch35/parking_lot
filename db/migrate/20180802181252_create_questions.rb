class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
