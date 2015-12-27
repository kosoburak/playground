class CreateKarmas < ActiveRecord::Migration
  def change
    create_table :karmas do |t|
      t.references :karmable, polymorphic: true, index: true, null: false
      t.references :author, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
  end
end
