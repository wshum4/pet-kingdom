class AddAnimaltoRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :requests, :animal, foreign_key: true
  end
end
