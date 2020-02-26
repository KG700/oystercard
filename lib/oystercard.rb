# to require or load:
# require '~/Dropbox/makers_projects/makers_week_02/oystercard/lib/oystercard.rb'
# load '~/Dropbox/makers_projects/makers_week_02/oystercard/lib/oystercard.rb'

class Oystercard

  CARD_MAX = 90.00
  @max_limit_error = "The limit is £#{CARD_MAX}"

  CARD_MIN = 1.00
  @min_limit_error = "The minimum balance to travel is £#{CARD_MIN}"

  attr_reader :balance, :in_journey_status, :entry_station

  def initialize
    @balance = 0.00
    @in_journey = false
    @entry_station = nil
  end

  def top_up(value)
    fail @max_limit_error if @balance + value > CARD_MAX
    @balance += value
  end


  def in_journey?
    @in_journey
  end

  def touch_in(station)
    fail @min_limit_error if @balance < CARD_MIN
    @entry_station = station
    @in_journey = true
  end

  def touch_out
    deduct(1.00)
    @entry_station = nil
    @in_journey = false
  end

  private
  def deduct(fare)
    @balance -= fare
  end


end
