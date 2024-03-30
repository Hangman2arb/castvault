class AddAvailableUntilToForms < ActiveRecord::Migration[7.1]
  def change
    add_column :forms, :available_until, :date
  end
end
