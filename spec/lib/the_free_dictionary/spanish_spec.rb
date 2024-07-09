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

        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/es/EU/dk/dkskdhdndfdssydyhn.mp3')
        expect(result[:transcription]).to eq("pa'laβɾa")
      end
    end

    it 'gets the information about `orquídea`' do
      word = 'orquídea'
      VCR.use_cassette('find_orquídea') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/es/EU/dk/dkslsgsgstnjdod5dtgk.mp3')
        expect(result[:transcription]).to eq('')
      end
    end

    it "doesn't get the information about `lleno de`" do
      word = 'lleno de'
      VCR.use_cassette('does_not_find_lleno_de') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('')
        expect(result[:transcription]).to eq('')
      end
    end
  end

  describe '#word_of_day' do
    it 'gets word of the day' do
      VCR.use_cassette('spanish_word_of_day') do
        result = dictionary.word_of_day
        expect(result[:word]).to eq('liquidez')
        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/es/EU/so/sod7drsgstd3dod5yjgk.mp3')
        expect(result[:transcription]).to eq("liki'deθ")
      end
    end
  end
end
