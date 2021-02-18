class CreateWords < ActiveRecord::Migration[6.0]
  def change
    create_table :words do |t|
      t.string :word, null: false, unique: true
      t.timestamps
    end
  end
end
