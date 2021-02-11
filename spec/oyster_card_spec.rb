require 'oystercard'

describe OysterCard do
  let(:station){ double :station }
  let(:station_2){ double :station_2 }
 test_value = 1

 before(:each) do
     @oystercard = OysterCard.new
   end

 describe '#top_up' do

  it "has a default balance of 0 when initialized" do
    expect(@oystercard.balance).to eq(0)
  end
 it "tops up with the top up value as the argument" do
   @oystercard.top_up(test_value)
   expect(@oystercard.balance).to eq test_value
 end
 it "raises an error when top up value exceeds maximum value" do
   @limit = OysterCard::MAXBALANCE
   @single_journey = OysterCard::SINGLE_JOURNEY
   @oystercard.top_up(@single_journey)
   expect { @oystercard.top_up(@limit) }.to raise_error "Your balance cannot be over £90"
 end
end

describe '#deduct' do
  before(:each) do
    @oystercard.top_up(1) 
  end

 it "deducts money from balance when you spend money" do
   @oystercard.deduct(test_value)
   expect(@oystercard.balance).to eq 0
 end
 it "deducts money of journey after journey completion" do
  @oystercard.touch_in(station)
  @oystercard.touch_out(station_2)
  expect(@oystercard.balance).to eq 0
  end
end

describe '#touch_in' do
  it "says you're in a journey when you touch in but don't touch out" do
  @oystercard.top_up(1)
  @oystercard.touch_in(station)
  expect(@oystercard.in_journey?).to eq true
  end

  it "raises an error if there isn't enough balance for single journey" do
    expect{ @oystercard.touch_in(station) }.to raise_error 'Not enough balance'
  end

    it 'saves users entry station' do
      @oystercard.top_up(1)
      expect(@oystercard.touch_in(station)).to eq station
    end

end

describe '#touch_out' do
  before(:each) do
    @oystercard.top_up(1) 
    @oystercard.touch_in(station)
  end
  it "says you are not in a journey after touching in and touching out" do
    @oystercard.touch_out(station_2)
    expect(@oystercard.in_journey?).to eq false
  end
end

describe '#journeys' do
  it "has an empty list of journeys by default" do
    expect(@oystercard.journeys).to eq []
  end
  it "creates one journey after touching in and out" do
    @oystercard.touch_out(station_2)
    expect((@oystercard.journeys).length).to eq 1
  end
end




end
