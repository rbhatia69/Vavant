class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :title
      t.text :description
      t.decimal :price
      t.float :rating
      t.boolean :enabled
      t.integer :user_id
      t.integer :collection_id
      t.integer :language_id
      t.integer :no_of_reviews
      t.integer :no_of_registrations
      t.string :photo_file_name
      t.string :photo_content_type
      t.integer :photo_file_size
      t.datetime :photo_updated_at

      t.timestamps
    end

    add_index :courses, :user_id
    add_index :courses, :collection_id

  end
end
