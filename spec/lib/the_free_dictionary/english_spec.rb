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

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/en/US/st/stdyd3sjsssydsstykgk.mp3')
        expect(result).to include(transcription: 'ˈɡlɒsərɪ')
      end
    end

    it 'gets the information about `affordable`' do
      word = 'affordable'
      VCR.use_cassette('find_affordable') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/en/US/df/dfdjdydtshssdodydosfdnh5h5.mp3')
        expect(result).to include(transcription: 'əˈfɔr də bəl, əˈfoʊr-')
      end
    end

    it "doesn't get the information about `01242`" do
      word = '01242'
      VCR.use_cassette('does_not_find_01242') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: '')
        expect(result).to include(transcription: '')
      end
    end

    context 'when the internet is disabled' do
      it 'returns empty result' do
        VCR.turn_off!
        WebMock.disable_net_connect!(allow_localhost: true)
        stub_request(:get, 'https://www.thefreedictionary.com/hello')
          .to_raise(Socket::ResolutionError.new('Simulated DNS resolution error'))
        word = 'hello'
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: '')
        expect(result).to include(transcription: '')
      end
    end
  end

  describe '#word_of_day' do
    it 'gets word of the day' do
      VCR.use_cassette('english_word_of_day') do
        result = dictionary.word_of_day
        expect(result[:word]).to eq('extralegal')
        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/en/US/d5/d5ddsosssdddsjd5dndosdh5h5.mp3')
        expect(result).to include(transcription: 'ˌɛkstrəˈliːɡəl')
      end
    end

    it 'gets word of the day with definition, synonyms and usage example' do
      VCR.use_cassette('english_word_of_day_definition_synonyms_example') do
        result = dictionary.word_of_day
        expect(result[:word]).to eq('ungainly')
        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/en/US/st/stsdsldodfd3sgshykgk.mp3')
        expect(result).to include(transcription: 'ʌnˈɡeɪnlɪ')
        expect(result).to include(definition: '(adjective) Lacking grace or ease of movement or form.')
        expect(result).to include(synonyms: "clumsy, clunky, gawky, unwieldy")
        expect(result).to include(usage: 'He was a gawky lad with long ungainly legs, but she thought he was the most handsome boy she had ever seen.')
      end
    end
  end
end
