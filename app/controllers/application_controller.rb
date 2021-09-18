class ApplicationController < ActionController::Base
  def set_date_from_select
    if params["starttime(1i)"].present?
      @starttime = get_date_from_params "starttime"
    else
      @starttime = DateTime.now - 1.day
    end

    if params["endtime(1i)"].present?
      @endtime = get_date_from_params "endtime"
    else
      @endtime = DateTime.now
    end
  end

  def get_date_from_params key
    DateTime.new(params["#{key}(1i)"].to_i,
    params["#{key}(2i)"].to_i,
    params["#{key}(3i)"].to_i,
    params["#{key}(4i)"].to_i,
    params["#{key}(5i)"].to_i).utc
  end
end
