class CoachSerializer
  include JSONAPI::Serializer
  attributes :id, :name

  attribute :image do |object|
    image = object.image
    Rails.application.routes.url_helpers.url_for(image) if image.attached?
  end
end
