class DateInterval
  attr_accessor :start_date, :end_date

  def initialize(start_date:, end_date: )
    @start_date = start_date
    @end_date = end_date
  end

  def overlaps_with_multiple_datimes(dates)
    dates.any? do |date|
      overlaps?(date[0], date[1])
    end
  end

  def overlaps?(other_start_date, other_end_date)
    start_date <= other_end_date && other_start_date <= end_date
  end
end
