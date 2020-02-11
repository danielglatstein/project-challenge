class Dog < ApplicationRecord
  paginates_per 5

  has_many_attached :images

  belongs_to :owner, foreign_key: :user_id, class_name: "User"
  has_many :likes

  scope :sorted_by_likes_in_past_hour , -> do
    joins("LEFT OUTER JOIN likes ON likes.dog_id = dogs.id AND likes.created_at >= datetime('now', '-1 Hour')")
      .group(:id)
      .order('COUNT(likes.id) DESC')
  end
end
