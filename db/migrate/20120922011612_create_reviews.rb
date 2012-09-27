class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.string :comment
      t.integer :course_id
      t.integer :rating

      t.timestamps
    end

    add_index :reviews, :course_id

  end
end
