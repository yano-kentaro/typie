class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :typing_score, null: false
      t.time :typing_time, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
