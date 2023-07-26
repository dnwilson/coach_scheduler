class Coach < ApplicationRecord
  has_one_attached :image
  has_many :slots, dependent: :destroy

  validates :name, presence: true

  def initials
    name.split(" ").compact_blank.map(&:first).join("").upcase
  end
end
