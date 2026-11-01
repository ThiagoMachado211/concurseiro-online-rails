class CreateQuestions < ActiveRecord::Migration[8.1]
  def change
    create_table :questions do |t|
      t.references :exam, null: false, foreign_key: true
      t.references :subject, null: false, foreign_key: true

      t.integer :number
      t.text :statement, null: false

      t.integer :modality, null: false, default: 0
      t.integer :difficulty, null: false, default: 0

      t.string :correct_answer

      t.integer :status, null: false, default: 0

      t.boolean :annulled, null: false, default: false
      t.boolean :outdated, null: false, default: false

      t.timestamps
    end

    add_index :questions, [:exam_id, :number], unique: true
    add_index :questions, :modality
    add_index :questions, :difficulty
    add_index :questions, :status
    add_index :questions, :annulled
    add_index :questions, :outdated
  end
end