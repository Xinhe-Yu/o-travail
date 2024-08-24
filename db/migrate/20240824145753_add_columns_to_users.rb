class AddColumnsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :username, :string
    add_column :users, :admin, :boolean, default: false
    add_column :users, :birthday, :date
    add_column :users, :profession, :integer
    add_column :users, :experience, :integer
    add_column :users, :terminology_preference, :integer, default: 2
  end
end
