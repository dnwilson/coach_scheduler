class ApplicationSerializer
  include JSONAPI::Serializer

  def self.serialize(object)
    return unless object
    new(object)&.serializable_hash[:data][:attributes]
  end
end