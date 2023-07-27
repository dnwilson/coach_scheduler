class CoachSerializer < ApplicationSerializer
  attributes :id, :name, :initials

  attribute :image do |object|
    image = object.image
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  attribute :slots do |object|
    object.slots.available.map do |slot|
      SlotSerializer.serialize(slot)
    end
  end

  attribute :appointments do |object|
    {
      available: build_appointments(object.appointments.available),
      completed: build_appointments(object.appointments.completed)
    }
  end

  def self.build_appointments(appointments)
    appointments.map { |appointment| AppointmentSerializer.serialize(appointment) }
  end
end
