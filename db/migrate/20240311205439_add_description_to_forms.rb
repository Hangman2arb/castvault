class AddDescriptionToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :description, :text
  end
end
