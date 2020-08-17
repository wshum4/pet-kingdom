class CreateSitterAcceptedAnimals < ActiveRecord::Migration[6.0]
  def change
    create_table :sitter_accepted_animals do |t|
      t.references :user, null: false, foreign_key: true
      t.string :type

      t.timestamps
    end
  end
end
