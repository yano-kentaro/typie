class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.string :typing_score, null: false
      t.string :typing_time, null: false
      t.references :book, null: false, foreign_key: true
      t.timestamps
    end
  end
end
