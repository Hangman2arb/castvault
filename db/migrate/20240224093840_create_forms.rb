class CreateForms < ActiveRecord::Migration[7.1]
  def change
    create_table :forms do |t|
      t.string :name
      t.integer :submissions_count, default: 0
      t.integer :completions_count, default: 0
      t.jsonb :fields, default: {}
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
