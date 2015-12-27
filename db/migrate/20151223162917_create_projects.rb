class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.references :author, references: :users, index: true, foreign_key: true, null: false
      t.string :locality

      t.timestamps null: false
    end
  end
end
