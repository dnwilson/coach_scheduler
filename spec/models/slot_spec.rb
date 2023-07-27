require 'rails_helper'

RSpec.describe Slot, type: :model do
  let(:slot) { build(:slot) }

  it { expect(slot).to respond_to(:appointment) }

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

        it { expect(slot.errors[:start_at]).to include("must be after #{Time.current.strftime("%Y-%m-%d %H:%M:%S")}") }
      end

      context "when coach already has a slot with the same time" do
        let(:existing_slot) { create(:slot, :with_coach) }
        let(:slot) { build(:slot, coach: existing_slot.coach, start_at: existing_slot.start_at + 30.minutes) }

        before { slot.valid? }

        it { expect(slot.errors[:start_at]).to include("has already been created") }
      end
    end
  end

  describe ".available" do
    let(:unavailable_slot) { create(:slot, :unavailable) }
    let(:slot) { create(:slot, :available, start_at: unavailable_slot.start_at + 3.hours) }
    let(:available) { slot.class.available }

    it { expect(available).to include(slot) }
    it { expect(available).not_to include(unavailable_slot) }
  end

  describe ".unavailable" do
    let(:unavailable_slot) { create(:slot, :unavailable) }
    let(:slot) { create(:slot, :available, start_at: unavailable_slot.start_at + 3.hours) }
    let(:unavailable) { slot.class.unavailable }

    it { expect(unavailable).not_to include(slot) }
    it { expect(unavailable).to include(unavailable_slot) }
  end
end
