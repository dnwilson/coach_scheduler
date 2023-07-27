class SlotSerializer < ApplicationSerializer
  attributes :id, :start_at, :end_at, :formatted_time

  attribute :appointment do |object|
    AppointmentSerializer.serialize(object.appointment)
  end

  attribute :available do |object|
    object.appointment.blank?
  end
end
