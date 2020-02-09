require 'rails_helper'

describe 'As a user', type: :feature do
  before do
    sign_in create(:user)
  end
  
  it 'I can create a profile' do
    visit new_dog_path

    fill_in 'Name', with: 'Speck'
    fill_in 'Description', with: 'Just a dog'
    attach_file 'Image', 'spec/fixtures/images/speck.jpg'
    click_button 'Create Dog'

    expect(page).to have_content("Speck's profile was successfully created")
    expect(page).to have_content("Edit Speck's Profile")
  end
end
