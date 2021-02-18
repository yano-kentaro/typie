class CreateBookScores < ActiveRecord::Migration[6.0]
  def change
    create_table :book_scores do |t|
      t.references :book, null:false, foreign_key: true
      t.references :score, null:false, foreign_key: true
      t.timestamps
    end
  end
end
