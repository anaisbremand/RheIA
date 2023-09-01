class CreateProgrammations < ActiveRecord::Migration[7.0]
  def change
    create_table :programmations do |t|
      t.datetime :open_at
      t.datetime :close_at
      t.references :post, null: false, foreign_key: true
      t.timestamps
    end
  end
end
