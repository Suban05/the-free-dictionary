# frozen_string_literal: true

RSpec.describe TheFreeDictionary::Spanish do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `palabra`' do
      word = 'palabra'
      VCR.use_cassette('find_palabra') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/es/EU/dk/dkskdhdndfdssydyhn.mp3')
        expect(result).to include(transcription: "pa'laβɾa")
      end
    end

    it 'gets the information about `orquídea`' do
      word = 'orquídea'
      VCR.use_cassette('find_orquídea') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/es/EU/dk/dkslsgsgstnjdod5dtgk.mp3')
        expect(result).to include(transcription: '')
      end
    end

    it "doesn't get the information about `lleno de`" do
      word = 'lleno de'
      VCR.use_cassette('does_not_find_lleno_de') do
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
      VCR.use_cassette('spanish_word_of_day') do
        result = dictionary.word_of_day
        expect(result[:word]).to eq('liquidez')
        expect(result).to include(sound: 'https://img2.tfd.com/pron/mp3/es/EU/so/sod7drsgstd3dod5yjgk.mp3')
        expect(result).to include(transcription: "liki'deθ")
      end
    end

    it 'gets word of the day with definition, synonyms and usage example' do
      VCR.use_cassette('spanish_word_of_day_definition_synonyms_example') do
        result = dictionary.word_of_day
        expect(result[:word]).to eq('matacán')
        expect(result).to include(sound: '')
        expect(result).to include(transcription: '')
        expect(result).to include(definition: '(sustantivo) En las antiguas fortificaciones, obra que sobresale en la parte superior de una muralla, torre o puerta, y que tiene parapeto y aberturas para defenderse del enemigo.')
        expect(result).to include(synonyms: "voladizo, saledizo, parapeto")
        expect(result).to include(usage: 'El capitán dirigió la defensa de la ciudad desde un matacán de la muralla.')
      end
    end
  end
end
