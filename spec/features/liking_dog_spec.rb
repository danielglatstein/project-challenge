require 'rails_helper'

describe 'As a user', type: :feature do
  let(:user) { create(:user) }
  let!(:dog) { create(:dog, name: "Dodger dog", owner: create(:user)) }
  
  before { sign_in user }

  it 'I can like a dog profile' do
    visit dogs_path

    click_link("Like")
    expect(page).to have_content("Likes: 1")
    click_link("Unlike")
    expect(page).to have_content("Likes: 0")
  end
end
