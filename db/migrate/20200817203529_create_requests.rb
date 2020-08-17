class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.references :owner, foreign_key: { to_table: :users }
      t.references :sitter, foreign_key: { to_table: :users }
      t.string :service
      t.date :start_date
      t.date :end_date
      t.integer :price
      t.string :animal
      t.text :animal_info
      t.boolean :housing
      t.boolean :accepted
      t.text :message

      t.timestamps
    end
  end
end
