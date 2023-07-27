class Slot < ApplicationRecord
  belongs_to :coach
  has_one :appointment

  before_validation :setup_end_at

  validates_datetime :start_at, after: -> { Time.current }
  validates_datetime :end_at, is_at: :valid_end_time
  validate :available_slot

  scope :for_range, ->(start_at, end_at, coach) {
    for_coach(coach)
      .where(start_at: start_at..end_at)
      .or(where(end_at: start_at..end_at))  }
  scope :for_coach, ->(coach) { where(coach: coach) }
  scope :available, -> { where.missing(:appointment) }
  scope :unavailable, -> { joins(:appointment) }

  def formatted_time
    time_format = "%l:%M%P"
    datetime_format = "%b %d, %Y #{time_format}"
    end_format = end_at.day != start_at.day ? datetime_format : time_format
    [start_at.strftime(datetime_format), end_at.strftime(end_format)].join(" - ")
  end

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
