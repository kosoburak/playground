class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.belongs_to :project, index: true, foreign_key: true, null: false
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :contract, index: true, foreign_key: true
      t.string :name
      t.text :description

      t.timestamps null: false
    end
  end
end
