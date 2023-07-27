module Api
  module V1
    class AppointmentsController < ApplicationController
      include Serializable

      def create
        @appointment = Appointment.new(appointment_params)
        if @appointment.save
          render json: serialized_response, status: :created
        else
          render json: {errors: @appointment.errors}, status: :unprocessable_entity
        end
      end

      def update
        @appointment = Appointment.find(params[:id])
        if @appointment.update(appointment_params)
          render json: serialized_response, status: :created
        else
          render json: {errors: @appointment.errors}, status: :unprocessable_entity
        end
      end

      private

      def appointment_params
        params.require(:appointment).permit(:slot_id, :student_id, :satisfaction, :notes)
      end
    end
  end  
end
