class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :subject
      t.text :body
      t.references :commenter, index: true
      t.boolean :is_public

      t.timestamps
    end
  end
end
