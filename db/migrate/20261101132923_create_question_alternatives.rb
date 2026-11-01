class CreateQuestionAlternatives < ActiveRecord::Migration[8.1]
  def change
    create_table :question_alternatives do |t|
      t.references :question, null: false, foreign_key: true

      t.string :letter, null: false, limit: 2
      t.text :text, null: false

      t.timestamps
    end

    add_index :question_alternatives,
              [:question_id, :letter],
              unique: true
  end
end