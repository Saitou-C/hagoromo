class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.string :tagname

      t.timestamps
    end
    add_index :tags, :tagname, unique: true #同じタグを作らないようにする(一意性)
  end
end
