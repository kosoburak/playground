class CreateContract < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.text :contract_name
    end
  end
end
