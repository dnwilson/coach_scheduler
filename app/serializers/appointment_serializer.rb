class AppointmentSerializer < ApplicationSerializer
  attributes :id, :slot_id, :student_id, :student_name, :student_image, :student_initials,
             :formatted_time, :completed_at, :completed, :satisfaction

  attribute :notes do |object|
    object.notes
  end

  attribute :student_image do |object|
    image = object.student.image
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
