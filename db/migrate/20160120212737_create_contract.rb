class CreateContract < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.text :name
    end
  end
end
