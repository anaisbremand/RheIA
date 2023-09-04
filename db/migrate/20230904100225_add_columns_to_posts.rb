class AddColumnsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :many_imgs, :integer
    add_column :posts, :imgs_style, :text
    add_column :posts, :images, :text, array: true, default: []
  end
end
