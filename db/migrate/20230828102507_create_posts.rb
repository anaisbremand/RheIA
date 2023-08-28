class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.text :prompt
      t.text :description
      t.boolean :draft, default: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
