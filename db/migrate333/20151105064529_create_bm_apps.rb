class CreateBmApps < ActiveRecord::Migration[7.0]
  def change
    create_table :bm_apps do |t|#, {:sequence_start_value => '1 cache 20 order increment by 1'} do |t|
      t.string :app_id, :limit => 20, :null => false
      t.string :channel_id, :limit => 20, :null => false
      t.integer :lock_version, :null => false
      t.string :approval_status, :limit => 1, :null => false
      t.string :last_action, :limit => 1
      t.integer :approved_version
      t.integer :approved_id
      
      t.timestamps null: false
    end
  end
end
