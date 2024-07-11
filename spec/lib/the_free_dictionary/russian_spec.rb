# frozen_string_literal: true

RSpec.describe TheFreeDictionary::Russian do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `картофель`' do
      word = 'картофель'
      VCR.use_cassette('find_картофель') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(:sound => 'https://img2.tfd.com/pron/mp3/ru/RU/g5/g5hrhjghgdghgoh5ghffgh.mp3')
        expect(result).to include(:transcription => 'kaˈrtofʲilʲ')
      end
    end
  end
end
