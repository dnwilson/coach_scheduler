module Api
  module V1
    class StudentsController < ApplicationController
      include Serializable

      def index
        @students = get_students
        render json: serialized_response, status: :ok
      end
    
      def show
        @student = get_students.find(params[:id])
        render json: serialized_response, status: :ok
      end
    
      def create
        @student = Student.new(student_params)
        if @student.save
          render json: serialized_response, status: :created
        else
          render json: {errors: @student.errors}, status: :unprocessable_entity
        end
      end

      private

      def get_students
        Student.with_attached_image.with_appointment_slots
      end

      def student_params
        params.require(:student).permit(:name, :image)
      end
    end
  end  
end
