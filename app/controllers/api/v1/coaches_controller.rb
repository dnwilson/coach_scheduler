module Api
  module V1
    class CoachesController < ApplicationController
      include Serializable

      def index
        @coaches = Coach.with_attached_image.all
        render json: serialized_response, status: :ok
      end
    
      def show
        @coach = Coach.with_attached_image.find(params[:id])
        render json: serialized_response, status: :ok
      end
    
      def create
        @coach = Coach.new(coach_params)
        if @coach.save
          render json: serialized_response, status: :created
        else
          render json: {errors: @coach.errors}, status: :unprocessable_entity
        end
      end

      private

      def coach_params
        params.require(:coach).permit(:name, :image)
      end
    end
  end  
end
