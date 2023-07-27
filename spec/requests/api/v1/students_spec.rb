require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  let(:valid_attributes) { attributes_for(:student) }
  let(:invalid_attributes) { attributes_for(:student, name: nil) }

  describe "POST /api/v1/students/create" do
    context "with valid parameters" do
      it "creates a new Student" do
        expect {
          post api_v1_students_url,
               params: { student: valid_attributes }, as: :json
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new student" do
        post api_v1_students_url,
             params: { student: valid_attributes }, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match(response_json(Student.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Student" do
        expect {
          post api_v1_students_url,
               params: { student: invalid_attributes }, as: :json
        }.to change(Student, :count).by(0)
      end

      it "renders a JSON response with errors for the new student" do
        post api_v1_students_url,
             params: { student: invalid_attributes }, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        expect(response.body).to match({errors: {name: ["can't be blank"]}}.to_json)
      end
    end
  end

  describe "GET /api/v1/students/:id" do
    it "renders a successful response" do
      student = Student.create! valid_attributes
      get api_v1_student_url(student), as: :json
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response.body).to match(response_json(Student.last))
    end
  end

  describe "GET /api/v1/students" do
    it "renders a successful response" do
      student = Student.create! valid_attributes
      get api_v1_students_url(student), as: :json
      expect(response).to be_successful
      expect(response.content_type).to match(a_string_including("application/json"))
      expect(response.body).to match([response_hash(Student.last)].to_json)
    end
  end

  def response_hash(student)
    {
      id: student.id,
      name: student.name,
      initials: student.initials,
      image: nil,
      slots: [],
      appointments: student.appointments
    }
  end

  def response_json(student)
    response_hash(student).to_json
  end
end
