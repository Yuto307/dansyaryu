class Post < ApplicationRecord
  mount_uploader :img, ImgUploader
  belongs_to :user

  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :votes, dependent: :destroy

  with_options presence: true do
    validates :title
    validates :body
    validates :status
  end

  enum status: { published: 0, draft: 1, closing: 2, trash: 3, untrash: 4 }

  def favorited_by(user)
    Favorite.find_by(user_id: user.id, post_id: id)
  end

  def voted_by(user)
    Vote.find_by(user_id: user.id, post_id: id)
  end
end
