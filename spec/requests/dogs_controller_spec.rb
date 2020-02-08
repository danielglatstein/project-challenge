require 'rails_helper'

RSpec.describe DogsController, type: :request do
  describe '#index' do
    let!(:rusty) { create(:dog) }
    let!(:trixie) { create(:dog) }
    
    it 'displays recent dogs' do
      get dogs_path

      expect(response).to be_successful
      expect(response.body).to include(rusty.name)
      expect(response.body).to include(trixie.name)
    end
  end
end
