class CreateQuestionTopics < ActiveRecord::Migration[8.1]
  def change
    create_table :question_topics do |t|
      t.references :question, null: false, foreign_key: true
      t.references :topic, null: false, foreign_key: true

      t.timestamps
    end

    add_index :question_topics,
              [:question_id, :topic_id],
              unique: true
  end
end