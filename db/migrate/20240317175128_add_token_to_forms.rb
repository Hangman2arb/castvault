class AddTokenToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :token, :string
    add_index :forms, :token, unique: true
  end
end
