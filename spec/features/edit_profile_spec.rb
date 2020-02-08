require 'rails_helper'

describe 'As a user', type: :feature do
  let(:dog) { create(:dog, name: "Dodger dog") }
  
  it 'I can edit a dog profile' do
    visit edit_dog_path(dog)

    expect(page).to have_content("Edit Dodger dog's profile")

    fill_in 'Name', with: 'Speck'
    click_button 'Update Dog'

    expect(page).to have_content("Dog was successfully updated")
    expect(page).to have_content("Edit Speck's Profile")
    expect(page).not_to have_content("Dodger dog")
  end
end
