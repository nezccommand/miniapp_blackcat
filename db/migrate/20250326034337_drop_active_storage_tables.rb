class DropActiveStorageTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :active_storage_variant_records, force: :cascade # 依存関係のあるテーブルも削除
    drop_table :active_storage_attachments, force: :cascade
    drop_table :active_storage_blobs, force: :cascade
  end
end
