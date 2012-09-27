class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :title
      t.string :description
      t.integer :course_id
      t.integer :sequence

      t.timestamps
    end

    add_index :lessons, :course_id
  end
end
