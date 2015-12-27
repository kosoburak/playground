class CreatePositions < ActiveRecord::Migration
  def change
    create_table :positions do |t|
      t.references :project, index: true, foreign_key: true, null: false
      t.references :user, index: true, foreign_key: true
      t.text :description

      t.timestamps null: false
    end
  end
end
