require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:appointment) { build(:appointment) }

  describe "#invalid?" do
    context "when slot is nil" do
      let(:appointment) { build(:appointment, slot: nil) }
      before { appointment.valid? }

      it { expect(appointment.errors[:slot]).to include("must exist") }
    end

    context "when student is nil" do
      let(:appointment) { build(:appointment, student: nil) }
      before { appointment.valid? }

      it { expect(appointment.errors[:student]).to include("must exist") }
    end
  end
end
