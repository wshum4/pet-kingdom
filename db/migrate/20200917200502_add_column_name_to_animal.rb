class AddColumnNameToAnimal < ActiveRecord::Migration[6.0]
  def change
    add_column :animals, :name, :string
  end
end
