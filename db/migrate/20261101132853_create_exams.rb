class CreateExams < ActiveRecord::Migration[8.1]
  def change
    create_table :exams do |t|
      t.string :name, null: false
      t.integer :year, null: false
      t.integer :level, null: false, default: 0

      t.references :exam_board, null: false, foreign_key: true
      t.references :institution, null: false, foreign_key: true
      t.references :position, null: false, foreign_key: true

      t.timestamps
    end

    add_index :exams, :year
    add_index :exams,
              [:exam_board_id, :institution_id, :position_id, :year],
              name: "index_exams_on_main_filters"
  end
end