class CreateBestAnswers < ActiveRecord::Migration[6.1]
  def change
    create_table :best_answers do |t|
      t.references :user, null: false, foreign_key: true
      t.references :comment, null: false, foreign_key: true

      t.timestamps
    end
  end
end
