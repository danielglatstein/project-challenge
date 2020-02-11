class Like < ApplicationRecord
  belongs_to :dog
  belongs_to :user

  validates :dog, :user, presence: true
  validates :dog, uniqueness: { scope: :user }
end
