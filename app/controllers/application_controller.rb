class ApplicationController < ActionController::API
  around_action :set_time_zone

  private

  def set_time_zone
    timezone = request.headers["X-TimeZone"] || "America/New_York"
    Time.use_zone(timezone) { yield }
  end
end
