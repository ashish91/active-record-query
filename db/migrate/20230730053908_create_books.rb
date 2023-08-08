class CreateBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :year_published
      t.string :isbn
      t.decimal :price
      t.integer :views, default: 0
      t.references :author, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true

      t.timestamps
    end
  end
end
