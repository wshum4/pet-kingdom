class RemoveColumnInAnimal < ActiveRecord::Migration[6.0]
  def change
    remove_column :animals, :photo_url, :string
  end
end
