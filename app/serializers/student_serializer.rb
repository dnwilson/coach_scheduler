class StudentSerializer < ApplicationSerializer
  attributes :id, :name, :initials

  attribute :image do |object|
    image = object.image
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  attribute :slots do |object|
    Slot.available.map do |slot|
      SlotSerializer.serialize(slot)
    end
  end

  attribute :appointments do |object|
    object.appointments.map do |appointment|
      AppointmentSerializer.serialize(appointment)
    end
  end
end
