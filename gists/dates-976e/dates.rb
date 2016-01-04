def month(n)
  months = %w[
    Jan
    Feb
    Mar
    Apr
    Maj
    Jun
    Jul
    Aug
    Sep
    Okt
    Nov
    Dec
  ]
  months[n]
end

def one_day  ; 24 * 3600   ; end
def one_week ; 7 * one_day ; end

def row(time, stop_time)
  month_start = month(time.month - 1)
  week_start = time.day
  week_end = (time + 6 * one_day).day

  if time.month == 1 && week_start < 7
    month_start = "'#{month_start} #{time.strftime('%y')}"
  end

  puts "#{month_start}\t#{week_start}\t#{week_end}"

  new_time  = (time + one_week)

  return if new_time > stop_time

  row(new_time, stop_time)
end

stop_after_x_months = 24
start_time = Time.mktime(2016,3,14)
stop_time = (start_time + stop_after_x_months * 4 * one_week)

row(start_time, stop_time)
