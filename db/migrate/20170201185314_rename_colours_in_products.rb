class RenameColoursInProducts < ActiveRecord::Migration[5.0]
  def change
  	rename_column :products, :colour, :colours 
  end
end
