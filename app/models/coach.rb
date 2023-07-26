class Coach < ApplicationRecord
  has_one_attached :image
  has_many :slots, dependent: :destroy

  validates :name, presence: true
end
