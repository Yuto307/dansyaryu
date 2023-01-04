class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :post

  with_options presence: true do
    validates :status
  end

  enum role: { none: 0, trash: 1, untrash: 2 }
end
