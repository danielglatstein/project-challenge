require 'rails_helper'

RSpec.describe DogsController, type: :request do
  describe "#new" do
    it 'returns 200 response' do
      get new_dog_path

      expect(response).to be_successful
    end
  end

  describe "#create" do
    let(:params) do
      { dog: { name: "Bowser", description: "A hunky husky" } }
    end

    context "valid record" do
      it 'returns 201 response' do
        expect { post dogs_path(params) }.to change {
          Dog.all.count
        }.from(0).to(1)

        expect(flash[:notice]).to eql("Bowser's profile was successfully created.")
      end
    end

    context "invalid record" do
      before do
        allow_any_instance_of(Dog).to receive(:save).and_return(false)
      end

      it 'returns 422 response' do
        expect { post dogs_path(params) }.not_to change {
          Dog.all.count
        }

        expect(response.status).to eql(422)
      end
    end
  end

  describe "#update" do
    let!(:rusty) { create(:dog, name: "Rusty") }
    let(:params) do
      { dog: { name: "Bowser" } }
    end

    context "valid record" do
      it 'returns 201 response' do
        expect { put dog_path(rusty.id, params: params) }.to change {
            rusty.reload.name
        }.from("Rusty").to("Bowser")
        

        expect(flash[:notice]).to eql("Bowser's profile was successfully updated.")
      end
    end

    context "invalid record" do
      before do
        allow_any_instance_of(Dog).to receive(:update).and_return(false)
      end

      it 'returns 422 response' do
        put dog_path(rusty.id, params: params)

        expect(response.status).to eql(422)
      end
    end
  end

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

  describe '#show' do
    let!(:rusty) { create(:dog) }
    
    it 'displays recent dogs' do
      expect(
        get dog_path(rusty.id)
      ).to render_template(:show)
    end
  end

  describe '#edit' do
    let!(:rusty) { create(:dog) }
    
    it 'displays recent dogs' do
      get edit_dog_path(rusty.id)

      expect(response).to be_successful

      expect(response.body).to include(rusty.name)
    end
  end

  describe '#destroy' do
    let!(:rusty) { create(:dog) }
    
    it 'displays recent dogs' do
      expect { delete dog_path(rusty.id) }.to change {
        Dog.all.count
      }.from(1).to(0)
    end
  end
end
