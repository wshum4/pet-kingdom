class RemoveColumnFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :animal
  end
end
