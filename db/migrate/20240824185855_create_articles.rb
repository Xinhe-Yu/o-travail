class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.integer :ref_num
      t.text :art_num
      t.string :loc, array: true
      t.string :title
      t.string :text
      t.boolean :status
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
