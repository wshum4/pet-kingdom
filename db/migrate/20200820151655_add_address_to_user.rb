class AddAddressToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :address, :string
    remove_column :users, :local_area
    remove_column :users, :verified
  end
end
