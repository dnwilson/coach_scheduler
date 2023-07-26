module Serializable
  extend ActiveSupport::Concern
  
  private

  def serialized_response
    @serialized_response ||= serialized_response_object
  end

  def serialized_response_object
    if serializable_instance.respond_to?(:map)
      serializable_instance.map { |o| serialize_object(o) }.to_json
    else
      serialize_object(serializable_instance)
    end
  end

  def serializable_instance
    instance_name = action_name == "index" ? controller_name : controller_name.singularize
    @serializable_instance ||= instance_variable_get("@#{instance_name}")
  end

  def serialize_object(object)
    klass = "#{object.class.name}Serializer".constantize
    klass.new(object).serializable_hash[:data][:attributes]
  end
end