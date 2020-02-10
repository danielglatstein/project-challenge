require 'rails_helper'

describe DogPolicy do
  subject { described_class }
  let(:user) { create(:user) }

  permissions :update?, :edit?, :destroy? do
    it "denies access if current user is not dogs owner" do
      expect(subject).not_to permit(user, create(:dog, owner: create(:user)))
    end

    it "grants access if current user is not dogs owner" do
      expect(subject).to permit(user, create(:dog, owner: user))
    end
  end

  permissions :new?, :create? do
    it "denies access if no current user" do
      expect(subject).not_to permit(nil, Dog.new)
    end

    it "grants access if current user" do
      expect(subject).to permit(user, Dog.new)
    end
  end

  permissions :like? do
    it "denies access if no current user" do
      expect(subject).not_to permit(nil, Dog.new)
    end

    context "current user" do
      it "denies access if user is dogs owner" do
        expect(subject).to permit(user, Dog.new)
      end

      it "grants access if current user is not dogs owner" do
        expect(subject).to permit(create(:user), Dog.new)
      end
    end
  end
end
