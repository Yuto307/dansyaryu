class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :post, null: false, foreign_key: true
      t.string :content, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
