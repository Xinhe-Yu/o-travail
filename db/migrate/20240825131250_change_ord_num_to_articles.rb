class ChangeOrdNumToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :ord_num, :integer
  end
end
