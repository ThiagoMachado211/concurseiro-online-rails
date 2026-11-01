class CreateAttempts < ActiveRecord::Migration[8.1]
  def change
    create_table :attempts do |t|
      t.references :user, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.string :answer
      t.boolean :correct

      t.timestamps
    end

    add_index :attempts, [:user_id, :created_at]
    add_index :attempts, [:user_id, :question_id]
    add_index :attempts, :correct
  end
end