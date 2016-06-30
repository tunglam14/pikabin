class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :syntax
      t.datetime :expire
      t.string :friendly_id
      t.timestamps null: false
    end
  end
end
