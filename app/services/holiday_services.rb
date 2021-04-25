require 'faraday'
require 'json'

class HolidayServices
  def get_holiday_name
    all_holidays = get_url("https://date.nager.at/Api/v2/NextPublicHolidays/US")

    all_holidays.map do |holiday|
      holiday[:name]
    end.first(3)
  end

  def get_url(url)
    response = Faraday.get(url)

    data = response.body
    JSON.parse(data, symbolize_names: true)
  end
end
