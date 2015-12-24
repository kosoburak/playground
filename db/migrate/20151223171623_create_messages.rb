class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.references :from, references: :users, index: true, foreign_key: true, null: false
      t.references :to, references: :users, index: true, foreign_key: true, null: false
      t.text :text, null: false
      t.datetime :send_time, null: false
      t.datetime :read_time

      t.timestamps null: false
    end
  end
end
