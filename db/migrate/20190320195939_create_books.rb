class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.text :title
      t.integer :pages
      t.integer :publication_year
      t.text :cover_art
      
      t.timestamps
    end
  end
end
