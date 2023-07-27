class Student < ApplicationRecord
  include Personifiable

  has_many :appointments, dependent: :destroy
  has_many :slots, through: :appointments

  scope :with_appointment_slots, -> { includes(appointments: :slot) }
end
