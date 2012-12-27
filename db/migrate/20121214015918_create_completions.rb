class CreateCompletions < ActiveRecord::Migration
  def change
    create_table :completions do |t|
      t.integer :lesson_id
      t.integer :course_id
      t.integer :user_id
      t.integer :status

      t.timestamps
    end

    add_index :completions, [:user_id, :course_id]
    add_index :completions, [:user_id, :lesson_id]

  end
end
