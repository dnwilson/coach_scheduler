module Api
  module V1
    class SlotsController < ApplicationController
      include Serializable

      def index
        @slots = Slot.all
        render json: serialized_response, status: :ok
      end
    
      def show
        @slot = Slot.with_attached_image.find(params[:id])
        render json: serialized_response, status: :ok
      end
    
      def create
        @slot = Slot.new(slot_params)
        if @slot.save
          render json: serialized_response, status: :created
        else
          render json: {errors: @slot.errors}, status: :unprocessable_entity
        end
      end

      private

      def slot_params
        params.require(:slot).permit(:coach_id, :start_at)
      end
    end
  end  
end
