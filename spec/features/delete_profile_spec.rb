require 'rails_helper'

describe 'Dog resource', type: :feature do
  let(:owner) { create(:user) }
  let(:dog) { create(:dog, owner: owner) }

  context "when dogs owner is current user" do
    before do
      sign_in owner
    end

    it 'can delete a dog profile' do
      visit dog_path(dog)

      click_link "Delete #{dog.name}'s Profile"
      
      expect(page).to have_content("#{dog.name.capitalize}'s profile was successfully destroyed.")
    end
  end

  context "when dogs owner is different user" do
    before do
      sign_in create(:user)
    end

    it 'cannot delete a dog profile' do
      visit dog_path(dog)

      expect(page).not_to have_link("Delete #{dog.name}'s Profile")
    end
  end
end
