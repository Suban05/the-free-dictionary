# frozen_string_literal: true

RSpec.describe TheFreeDictionary::Chinese do
  let(:dictionary) do
    described_class.new
  end

  describe '#find' do
    it 'gets the information about `是`' do
      word = '是'
      VCR.use_cassette('find_是') do
        result = dictionary.find(word)
        expect(result).to be_an_instance_of(Hash)
        expect(result).to have_key(:sound)
        expect(result).to have_key(:transcription)

        expect(result[:sound]).to eq('https://img2.tfd.com/pron/mp3/zh/CN/jn/jnhlhh.mp3')
        expect(result[:transcription]).to eq('')
      end
    end
  end
end
