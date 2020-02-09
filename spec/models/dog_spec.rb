require 'rails_helper'

RSpec.describe Dog, type: :model do
  it { is_expected.to belong_to(:owner) }
end
