require 'rails_helper'

RSpec.describe Coach, type: :model do
  let(:coach) { build(:coach) }

  it { expect(coach).to respond_to(:slots) }

  describe "#invalid" do
    context "when name is nil" do
      let(:coach) { build(:coach, name: nil) }

      it { expect(coach).to be_invalid }
    end
  end
end
