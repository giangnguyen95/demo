class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :type
      t.text :description
      t.string :author

      t.timestamps
    end
  end
end
