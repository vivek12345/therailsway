class AddShowPostToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :showpost, :text

  end
end
