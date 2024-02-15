class SetUserTimeZoneAndLanguageJob < ApplicationJob
  queue_as :default

  def perform(user_id, ip_address)
    user = User.find_by(id: user_id)
    return unless user

    ip = Rails.env.test? || ip_address == '127.0.0.1' ? '37.223.187.97' : ip_address
    time_zone = fetch_time_zone_from_ip(ip)
    language = I18n.locale.to_s

    user.update(time_zone: time_zone, language: language)
  end

  private

  def fetch_time_zone_from_ip(ip)
    response = HTTParty.get("https://api.ipgeolocation.io/timezone?apiKey=e75bf160a662471fbcc52b1d380e6928&ip=#{ip}")
    if response.success?
      data = response.parsed_response
      data['timezone']
    else
      'UTC'
    end
  rescue => e
    'UTC'
  end
end
