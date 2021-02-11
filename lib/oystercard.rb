class OysterCard
DEFAULTBALANCE = 0
MAXBALANCE = 90
SINGLE_JOURNEY = 1
attr_reader :balance, :entry_station, :journeys, :exit_station

  def initialize(balance = DEFAULTBALANCE,single_journey = SINGLE_JOURNEY)
    @balance = balance
    @single_journey = single_journey
    @entry_station = nil
    @exit_station = nil
    @journeys = []
  end

  def top_up(top_up_value)
    @balance = @balance + top_up_value
    fail "Your balance cannot be over £#{MAXBALANCE}" if @balance > MAXBALANCE
  end

  def deduct(single_journey)
    @balance -= single_journey
  end

  def touch_in(station)
    raise "Not enough balance" if @balance < @single_journey
    @exit_station = nil
    @entry_station = station
  end

  def touch_out(station_2)
    deduct(@single_journey)
    @exit_station = station_2
    journey1 = {entry_station: @entry_station, exit_station: @exit_station}
    @journeys << journey1
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end


end
