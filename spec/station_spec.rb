require 'station'

describe Station do
  let(:station) {described_class.new(:name, :zone)}

  it 'has name value' do
    expect(station.name).to eq :name
  end
  it 'has zone value' do
    expect(station.zone).to eq :zone    
  end
end
