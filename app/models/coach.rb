class Coach < ApplicationRecord
  include Personifiable

  has_many :slots, dependent: :destroy
  has_many :appointments, through: :slots
end
