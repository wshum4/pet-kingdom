class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false, default: 0
      t.text :content
      t.references :request, null: false, foreign_key: true

      t.timestamps
    end
  end
end
