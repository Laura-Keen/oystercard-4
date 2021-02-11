require 'station'

describe Station do
  let(:name){ double :name }
  let(:zone){ double :zone }
  
  before(:each) do
    @station = Station.new
  end

  it 'says what zone a station is in' do
    expect(@station.zone).to eq zone
  end
end