class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students123 do |t|
      t.string :name
      t.string :approval_status
      t.integer :lock_version
      t.integer :approved_id
      t.timestamps
    end
  end
end
