# frozen_string_literal: true

RSpec.describe TheFreeDictionary::English do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `glossary`' do
      word = 'glossary'
      VCR.use_cassette('find_glossary') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/en/US/st/stdyd3sjsssydsstykgk.mp3')
        expect(result[:transcription]).to eq('ˈɡlɒsərɪ')
      end
    end

    it 'gets the information about `affordable`' do
      word = 'affordable'
      VCR.use_cassette('find_affordable') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/en/US/df/dfdjdydtshssdodydosfdnh5h5.mp3')
        expect(result[:transcription]).to eq('əˈfɔr də bəl, əˈfoʊr-')
      end
    end

    it "doesn't get the information about `01242`" do
      word = '01242'
      VCR.use_cassette('does_not_find_01242') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('')
        expect(result[:transcription]).to eq('')
      end
    end
  end
end
