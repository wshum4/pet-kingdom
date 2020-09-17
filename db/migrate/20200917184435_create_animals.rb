class CreateAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :animals do |t|
      t.text :description
      t.string :photo_url
      t.references :owner, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
