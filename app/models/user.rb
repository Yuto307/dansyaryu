class User < ApplicationRecord
  authenticates_with_sorcery!

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_posts, through: :favorites, source: :post
  has_many :votes, dependent: :destroy
  has_many :vote_posts, through: :votes, source: :post
  has_many :best_answers, dependent: :destroy

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :name, presence: true, length: { maximum: 255 }

  validates :email, uniqueness: true

  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  def favorite(post)
    favorites.create!(post_id: post.id)
  end

  def unfavorite(post)
    favorite_posts.delete(post)
  end

  def favorite?(post)
    Favorite.where(user_id: id, post_id: post.id).exists?
  end

  def unvote(post)
    vote_posts.delete(post)
  end

  def vote?(post)
    Vote.where(user_id: id, post_id: post.id).exists?
  end

  def best_answer(comment)
    favorites.create!(comment_id: comment.id)
  end

  def usually_answer(comment)
    BestAnswer.where(user_id: id, comment_id: comment.id).delete
  end

  def best_answer?(comment)
    BestAnswer.where(user_id: id, comment_id: comment.id).exists?
  end
end
