class CreateMaterialsLessonsJoinTable < ActiveRecord::Migration
  def up
    create_table :lessons_materials do |t|
      t.integer :lesson_id
      t.integer :material_id
    end

  end

  def down
    drop_table :lessons_materials
  end
end
