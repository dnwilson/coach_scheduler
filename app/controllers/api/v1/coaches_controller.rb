module Api
  module V1
    class CoachesController < ApplicationController
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

      def serialized_response
        @serialized_response ||= serialized_response_object
      end

      def serialized_response_object
        object = action_name == "index" ? @coaches : @coach
        
        if object.respond_to?(:map)
          object.map { |o| serialize_object(o) }.to_json
        else
          serialize_object(object)
        end
      end

      def serialize_object(object)
        CoachSerializer.new(object).serializable_hash[:data][:attributes]
      end

      def coach_params
        params.require(:coach).permit(:name, :image)
      end
    end
  end  
end
