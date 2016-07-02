class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.text :content
      t.string :syntax
      t.string :expired_at
      t.string :friendly_id
      t.timestamps null: false
    end
  end
end
