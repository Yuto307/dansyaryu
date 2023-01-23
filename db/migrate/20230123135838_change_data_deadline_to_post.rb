class ChangeDataDeadlineToPost < ActiveRecord::Migration[6.1]
  def change
    change_column :posts, :deadline, :datetime
  end
end
