class AddUserToArticles < ActiveRecord::Migration[8.0]
  def change
    add_reference :articles, :user, null: false, foreign_key: true
  end
end
