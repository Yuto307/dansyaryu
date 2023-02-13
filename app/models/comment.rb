class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  has_one :best_answer

  with_options presence: true do
    validates :content
    validates :status
  end

  validates :content, presence: true, length: { maximum: 65_535 }

  enum status: { unanswer: 0, trash: 1, untrash: 2 }
end
