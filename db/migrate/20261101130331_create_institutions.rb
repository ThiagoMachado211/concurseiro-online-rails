class CreateInstitutions < ActiveRecord::Migration[8.1]
  def change
    create_table :institutions do |t|
      t.string :name, null: false
      t.string :acronym

      t.timestamps
    end

    add_index :institutions, :name, unique: true
    add_index :institutions, :acronym
  end
end