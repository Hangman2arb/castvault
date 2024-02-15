class CreateProfiles < ActiveRecord::Migration[7.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surname
      t.date :birthdate
      t.string :ethnicity
      t.string :gender
      t.string :city
      t.string :email
      t.string :phone
      t.string :agency
      t.string :agent_name
      t.string :agent_email
      t.string :agent_phone
      t.integer :height
      t.integer :shirt_size
      t.integer :pants_size
      t.integer :shoe_size
      t.string :hair_type
      t.string :hair_color
      t.string :eye_color
      t.boolean :passport
      t.boolean :driving_license
      t.text :food_allergies
      t.string :web
      t.string :twitter
      t.string :facebook
      t.string :instagram

      t.timestamps
    end
  end
end
