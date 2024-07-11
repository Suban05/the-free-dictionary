# frozen_string_literal: true

RSpec.describe TheFreeDictionary::Italian do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `ciao`' do
      word = 'ciao'
      VCR.use_cassette('find_ciao') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/it/IT/dn/dndgdrdgshht.mp3')
        expect(result).to include(transcription: "'tʃao")
      end
    end
  end
end
