class ChangeArtNumToStringInArticles < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :art_num, :string
  end
end
