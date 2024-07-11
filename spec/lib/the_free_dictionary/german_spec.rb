# frozen_string_literal: true

RSpec.describe TheFreeDictionary::German do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `lesen`' do
      word = 'lesen'
      VCR.use_cassette('find_lesen') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/de/DE/d3/d3d7dssddtshhr.mp3')
        expect(result).to include(transcription: 'ˈleːzən')
      end
    end
  end
end
