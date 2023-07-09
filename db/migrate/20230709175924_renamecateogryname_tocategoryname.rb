class RenamecateogrynameTocategoryname < ActiveRecord::Migration[7.0]
  def change
    rename_column :categories, :cateogryname, :categoryname
  end
end
