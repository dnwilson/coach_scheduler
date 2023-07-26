class CoachSerializer
  include JSONAPI::Serializer
  attributes :id, :name, :initials

  attribute :image do |object|
    image = object.image
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end

  attribute :slots do |object|
    object.slots.map do |slot|
      SlotSerializer.serialize(slot)
    end
  end
end
