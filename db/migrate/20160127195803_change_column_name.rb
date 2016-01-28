class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :contracts, :contract_name, :name
  end
end
