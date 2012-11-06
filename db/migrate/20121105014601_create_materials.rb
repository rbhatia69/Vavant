class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.integer :content_type
      t.text :detail_content
      t.text :embedded_content
      t.string :stored_file_name
      t.string :stored_content_type
      t.integer :stored_file_size
      t.datetime :stored_updated_at

      t.timestamps
    end
  end
end
