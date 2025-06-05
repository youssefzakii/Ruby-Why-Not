class RenameArticlesToPosts < ActiveRecord::Migration[8.0]
  def change
    rename_table :articles, :posts
    rename_column :posts, :archived, :hidden
    rename_column :posts, :reports_count, :flag_count
  end
end 