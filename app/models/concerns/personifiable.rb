module Personifiable
  extend ActiveSupport::Concern

  included do
    has_one_attached :image

    validates :name, presence: true
  end

  def initials
    name.split(" ").compact_blank.map(&:first).join("").upcase
  end
end