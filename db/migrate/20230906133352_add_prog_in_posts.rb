class AddProgInPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :program, :datetime
  end
end
