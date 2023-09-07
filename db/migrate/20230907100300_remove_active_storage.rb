class RemoveActiveStorage < ActiveRecord::Migration[7.0]
  def change
    drop_table :active_storage_attachments, cascade: true
    drop_table :active_storage_variant_records, cascade: true
    drop_table :active_storage_blobs, cascade: true
  end

end
