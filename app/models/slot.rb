class Slot < ApplicationRecord
  belongs_to :coach

  before_validation :setup_end_at

  validates_time :start_at, on_or_after: -> { Time.current }
  validates_time :end_at, is_at: :valid_end_time
  validate :available_slot

  scope :for_range, ->(start_at, end_at, coach) {
    comparison_string = "'#{start_at}' AND '#{start_at + 2.hours}'"
    for_coach(coach)
    .where("start_at BETWEEN #{comparison_string} OR end_at BETWEEN #{comparison_string}")
  }
  scope :for_coach, ->(coach) { where(coach: coach) }


  private

  def available_slot
    return unless self.class.for_range(start_at, end_at, coach).exists?

    errors.add(:start_at, "has already been created")
  end

  def setup_end_at
    return unless new_record? || start_at_changed?
    return if start_at.blank?

    self.end_at = start_at + 2.hours
  end

  def valid_end_time
    return unless start_at

    start_at + 2.hours
  end
end
