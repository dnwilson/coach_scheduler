require 'rails_helper'

RSpec.describe "Api::V1::Slots", type: :request do
  let(:coach_id) { create(:coach).id }
  let(:valid_attributes) { attributes_for(:slot, coach_id: coach_id) }
  let(:invalid_attributes) { attributes_for(:slot, start_at: 1.minute.from_now) }

  describe "POST /api/v1/slots/create" do
    context "with valid parameters" do
      it "creates a new Slot" do
        expect {
          post api_v1_slots_url,
               params: { slot: valid_attributes }, as: :json
        }.to change(Slot, :count).by(1)
      end

      it "renders a JSON response with the new slot" do
        post api_v1_slots_url,
             params: { slot: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match(response_json(Slot.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Slot" do
        expect {
          post api_v1_slots_url,
               params: { slot: invalid_attributes }, as: :json
        }.to change(Slot, :count).by(0)
      end

      it "renders a JSON response with errors for the new slot" do
        post api_v1_slots_url,
             params: { slot: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match({errors: {coach: ["must exist"]}}.to_json)
      end
    end
  end

  describe "GET /api/v1/slots" do
    it "renders a successful response" do
      slot = Slot.create! valid_attributes
      get api_v1_slots_url(slot), as: :json
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response.body).to match(response_json(Slot.last))
    end
  end

  def response_json(slot)
    {
      id: slot.id,
      start_at: slot.start_at,
      end_at: slot.end_at,
      formatted_time: slot.formatted_time
    }.to_json
  end
end
