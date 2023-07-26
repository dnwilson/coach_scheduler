module Api
  module V1
    class CoachesController < ApplicationController
      def index
      end
    
      def show
      end
    
      def create
        @coach = Coach.new(coach_params)
        if @coach.save
          render json: serialized_record, status: :created
        else
          render json: {errors: @coach.errors}, status: :unprocessable_entity
        end
      end

      private

      def serialized_record
        @serialized_record ||= CoachSerializer.new(@coach).serializable_hash[:data][:attributes].to_json
      end

      def coach_params
        params.require(:coach).permit(:name, :image)
      end
    end
  end  
end
