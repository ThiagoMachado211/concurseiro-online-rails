class CreateTopics < ActiveRecord::Migration[8.1]
  def change
    create_table :topics do |t|
      t.string :name, null: false

      t.references :subject,
                   null: false,
                   foreign_key: true

      t.references :parent,
                   null: true,
                   foreign_key: { to_table: :topics }

      t.timestamps
    end

    add_index :topics,
              [:subject_id, :name, :parent_id],
              unique: true
  end
end