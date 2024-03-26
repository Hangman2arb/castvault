class AddWebLinkToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :web_link, :string
  end
end
