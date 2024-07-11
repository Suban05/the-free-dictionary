# frozen_string_literal: true

RSpec.describe TheFreeDictionary::French do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `bonjour`' do
      word = 'bonjour'
      VCR.use_cassette('find_bonjour') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(:sound => 'https://img2.tfd.com/pron/mp3/fr/EU/sj/sjdhskskd3sgsrsthn.mp3')
        expect(result).to include(:transcription => 'bɔ̃ʒuʀ')
      end
    end
  end
end
