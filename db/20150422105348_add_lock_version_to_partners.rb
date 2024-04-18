class AddLockVersionToPartners < ActiveRecord::Migration[7.0]
  def change
    add_column :partners, :lock_version, :integer
  end
end
