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
      t.boolean :agency, default: false
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
      t.boolean :passport, default: false
      t.boolean :driving_license, default: false
      t.text :food_allergies
      t.string :web
      t.string :twitter
      t.string :facebook
      t.string :instagram
      t.string :tik_tok
      t.boolean :is_an_actor, default: false
      t.json :languages, default: []
      t.json :available_for, default: []
      # Features as JSON columns
      Form::FEATURES_OPTIONS.each_key do |category|
        t.json category, default: []
      end
      t.boolean :performing_arts, default: false
      t.boolean :tv, default: false
      t.boolean :fiction, default: false
      t.boolean :advertising, default: false
      t.references :form
      t.references :user

      t.timestamps
    end
  end
end
