class CreateBookLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :book_languages do |t|
      t.references :book, null:false, foreign_key: true
      t.references :language, null:false, foreign_key: true
      t.timestamps
    end
  end
end
