class CreateLanguages < ActiveRecord::Migration[6.0]
  def change
    create_table :languages do |t|
      t.string :name, null: false, unique: true
      t.integer :color_id, null: false
      t.timestamps
    end
  end
end
