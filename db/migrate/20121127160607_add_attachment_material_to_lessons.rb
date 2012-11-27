class AddAttachmentMaterialToLessons < ActiveRecord::Migration
  def self.up
    change_table :lessons do |t|
      t.has_attached_file :material
    end
  end

  def self.down
    drop_attached_file :lessons, :material
  end
end
