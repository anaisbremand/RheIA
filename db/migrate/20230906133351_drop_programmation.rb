class DropProgrammation < ActiveRecord::Migration[7.0]
  def change
    drop_table :programmations
  end
end
