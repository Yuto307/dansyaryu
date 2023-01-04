class Post < ApplicationRecord
  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :votes, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
    validates :tatus
  end

  enum role: { draft: 0, published: 1, closing: 2, trash: 3, untrash: 4 }
end
