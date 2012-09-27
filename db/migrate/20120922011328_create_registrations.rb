class CreateRegistrations < ActiveRecord::Migration
  def change
    create_table :registrations do |t|
      t.integer :user_id
      t.integer :course_id
      t.decimal :price

      t.timestamps
    end

    add_index :registrations, [:user_id, :course_id], :unique => true

  end
end
