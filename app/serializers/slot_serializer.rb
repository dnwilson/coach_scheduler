class SlotSerializer
  include JSONAPI::Serializer
  attributes :id, :start_at, :end_at, :formatted_time

  def self.serialize(slot)
    new(slot).serializable_hash[:data][:attributes]
  end
end
