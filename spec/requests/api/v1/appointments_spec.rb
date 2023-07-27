require 'rails_helper'

RSpec.describe "Api::V1::Appointments", type: :request do
  let(:slot) { create(:slot, :with_coach) }
  let(:student) { create(:student) }
  let(:valid_attributes) { attributes_for(:appointment, slot_id: slot.id, student_id: student.id) }
  let(:invalid_attributes) { attributes_for(:appointment, slot_id: slot.id, student_id: nil) }

  describe "POST /api/v1/appointments/create" do
    context "with valid parameters" do
      it "creates a new Appointment" do
        expect {
          post api_v1_appointments_url,
               params: { appointment: valid_attributes }, as: :json
        }.to change(Appointment, :count).by(1)
      end

      it "renders a JSON response with the new appointment" do
        post api_v1_appointments_url,
             params: { appointment: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match(response_json(Appointment.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Appointment" do
        expect {
          post api_v1_appointments_url,
               params: { appointment: invalid_attributes }, as: :json
        }.to change(Appointment, :count).by(0)
      end

      it "renders a JSON response with errors for the new student" do
        post api_v1_appointments_url,
             params: { appointment: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match({errors: {student: ["must exist"]}}.to_json)
      end
    end
  end

  # describe "GET /api/v1/appointments/:id" do
  #   it "renders a successful response" do
  #     student = Appointment.create! valid_attributes
  #     get api_v1_student_url(student), as: :json
  #     expect(response).to be_successful
  #     expect(response.content_type).to match(a_string_including("application/json"))
  #     expect(response.body).to match(response_json(Appointment.last))
  #   end
  # end

  # describe "GET /api/v1/appointments" do
  #   it "renders a successful response" do
  #     student = Appointment.create! valid_attributes
  #     get api_v1_appointments_url(student), as: :json
  #     expect(response).to be_successful
  #     expect(response.content_type).to match(a_string_including("application/json"))
  #     expect(response.body).to match([response_hash(Appointment.last)].to_json)
  #   end
  # end

  def response_hash(appointment)
    {
      id: appointment.id,
      slot_id: appointment.slot_id,
      student_id: appointment.student_id,
      completed_at: appointment.completed_at,
      completed: appointment.completed,
      satisfaction: appointment.satisfaction,
      notes: appointment.notes.to_plain_text.presence
    }
  end

  def response_json(student)
    response_hash(student).to_json
  end
end
