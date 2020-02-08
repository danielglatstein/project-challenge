require 'rails_helper'

describe 'Dog resource', type: :feature do
  let(:dog) { create(:dog) }

  it 'can delete a dog profile' do
    visit dog_path(dog)

    click_link "Delete #{dog.name}'s Profile"
    
    expect(page).to have_content("#{dog.name.capitalize}'s profile was successfully destroyed.")
  end
end
