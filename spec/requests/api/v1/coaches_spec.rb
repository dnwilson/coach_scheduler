require 'rails_helper'

RSpec.describe "Api::V1::Coaches", type: :request do
  let(:valid_attributes) { attributes_for(:coach) }
  let(:invalid_attributes) { attributes_for(:coach, name: nil) }

  describe "POST /api/v1/coaches/create" do
    context "with valid parameters" do
      it "creates a new Coach" do
        expect {
          post api_v1_coaches_url,
               params: { coach: valid_attributes }, as: :json
        }.to change(Coach, :count).by(1)
      end

      it "renders a JSON response with the new coach" do
        post api_v1_coaches_url,
             params: { coach: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match(response_json(Coach.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Coach" do
        expect {
          post api_v1_coaches_url,
               params: { coach: invalid_attributes }, as: :json
        }.to change(Coach, :count).by(0)
      end

      it "renders a JSON response with errors for the new coach" do
        post api_v1_coaches_url,
             params: { coach: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match({errors: {name: ["can't be blank"]}}.to_json)
      end
    end
  end

  describe "GET /api/v1/coaches/:id" do
    it "renders a successful response" do
      coach = Coach.create! valid_attributes
      get api_v1_coach_url(coach), as: :json
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response.body).to match(response_json(Coach.last))
    end
  end

  describe "GET /api/v1/coaches" do
    it "renders a successful response" do
      coach = Coach.create! valid_attributes
      get api_v1_coaches_url(coach), as: :json
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      # expect(response.body).to match(response_json(Coach.last))
    end
  end

  def response_json(coach)
    {
      id: coach.id,
      name: coach.name,
      initials: coach.initials,
      image: nil,
      slots: coach.slots,
    }.to_json
  end
end
