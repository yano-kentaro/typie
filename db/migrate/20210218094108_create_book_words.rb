class CreateBookWords < ActiveRecord::Migration[6.0]
  def change
    create_table :book_words do |t|
      t.references :book, null:false, foreign_key: true
      t.references :word, null:false, foreign_key: true
      t.timestamps
    end
  end
end
