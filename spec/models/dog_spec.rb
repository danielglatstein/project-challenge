require 'rails_helper'

RSpec.describe Dog, type: :model do
  it { is_expected.to belong_to(:owner) }

  context ".sorted_by_likes_in_past_hour" do
    let!(:dog_with_most_likes) do
      create(:dog, owner: create(:user)).tap do |dog|
        create_list(:like, 10, dog: dog)
      end
    end

    let!(:yesterdays_news) do
      create(:dog, owner: create(:user)).tap do |dog|
        create_list(:like, 20, dog: dog, created_at: 1.day.ago)
      end
    end

    let!(:liked_dog) do 
      create(:dog, owner: create(:user)).tap do |dog|
        create(:like, dog: dog)
      end
    end

    it "returns dogs sorted by likes in the past hour" do
      expect(described_class.sorted_by_likes_in_past_hour.map(&:id)).to eql(
        [dog_with_most_likes.id, liked_dog.id, yesterdays_news.id]
      )
    end
  end
end
