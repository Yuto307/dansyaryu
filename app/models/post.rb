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
    validates :deadline
  end

  enum status: { published: 0, draft: 1, closing: 2, trash: 3, untrash: 4 }

  scope :past_closing, -> { where('deadline <= ?', Time.current) }

  # 締切時間が過ぎているか
  def closed?
    Time.current >= deadline
  end

  # draft(下書き)であればreturn
  # 締切時間が過ぎていれば締切。過ぎていなければ公開のままにする
  def adjust_status
    return if draft?

    self.status = if closed?
                    :closing
                  else
                    :published
                  end
  end

  def message_on_closing
    if published?
      '記事を公開しました'
    elsif closing?
      '記事を締め切りました'
    end
  end

  def favorited_by(user)
    Favorite.find_by(user_id: user.id, post_id: id)
  end

  def voted_by(user)
    Vote.find_by(user_id: user.id, post_id: id)
  end
end
