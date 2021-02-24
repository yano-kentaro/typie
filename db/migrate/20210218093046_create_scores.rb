class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.integer :typing_score, null: false
      t.string :typing_time, null: false
      t.timestamps
    end
  end
end
