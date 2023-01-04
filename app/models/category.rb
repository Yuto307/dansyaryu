class Category < ApplicationRecord
  has_many :post_categories
  has_many :post, through: :post_categories

  with_options presence: true do
    validates :name
  end
end
