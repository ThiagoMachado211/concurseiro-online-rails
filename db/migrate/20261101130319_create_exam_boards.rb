class CreateExamBoards < ActiveRecord::Migration[8.1]
  def change
    create_table :exam_boards do |t|
      t.string :name, null: false
      t.string :acronym

      t.timestamps
    end

    add_index :exam_boards, :name, unique: true
    add_index :exam_boards, :acronym
  end
end