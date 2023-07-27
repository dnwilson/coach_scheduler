require 'rails_helper'

RSpec.describe Student, type: :model do
  let(:student) { build(:student) }

  it { expect(student).to respond_to(:appointments) }
  it { expect(student).to respond_to(:slots) }

  describe "#invalid" do
    context "when name is nil" do
      let(:student) { build(:student, name: nil) }

      it { expect(student).to be_invalid }
    end
  end
end
