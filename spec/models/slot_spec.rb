require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:slot) { build(:slot) }

  describe "#save" do
    before { slot.save }

    it "automatically sets end at" do
      expect(slot.end_at).to eq(slot.start_at + 2.hours)
    end
  end

  describe "#invalid?" do
    describe "#start_at" do
      context "when is in the past" do
        let(:slot) { build(:slot, :with_coach, start_at: start_at) }
        let(:start_at) { 1.hour.ago }
        
        before { slot.valid? }

        it { expect(slot.errors[:start_at]).to include("must be on or after #{Time.current.strftime("%H:%M:%S")}") }
      end

      context "when coach already has a slot with the same time" do
        let(:existing_slot) { create(:slot, :with_coach) }
        let(:slot) { build(:slot, coach: existing_slot.coach, start_at: existing_slot.start_at + 30.minutes) }

        before { slot.valid? }

        it { expect(slot.errors[:start_at]).to include("has already been created") }
      end
    end
  end
end
