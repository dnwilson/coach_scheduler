class Appointment < ApplicationRecord
  belongs_to :slot
  belongs_to :student

  delegate :name, :initials, to: :student, prefix: true
  delegate :formatted_time, to: :slot

  scope :available, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }

  before_save :complete_appointment

  validates :satisfaction, presence: true, on: :update

  def completed
    completed_at?
  end

  private

  def complete_appointment
    return if completed_at?

    self.completed_at = Time.current
  end
end
