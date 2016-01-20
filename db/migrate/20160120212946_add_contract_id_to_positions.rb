class AddContractIdToPositions < ActiveRecord::Migration
  def change
    add_column :positions, :contract_id, :integer
    add_index :positions, :contract_id
  end
end
