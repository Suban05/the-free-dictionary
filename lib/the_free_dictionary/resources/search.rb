# frozen_string_literal: true

require 'net/http'

module TheFreeDictionary
  module Resources
    class Search < Resource
      attr_accessor :word

      def call
        uri = build_uri("#{base_url}/#{@word}")
        response = fetch(uri)
        sound = build_sound_url(response)
        transcription = fetch_transcription(response)

        { sound:, transcription: }
      end

      private

      def build_sound_url(response)
        sound_data = response.body.match(%r{#{@dictionary.language}/#{@dictionary.region}[^"]+})
        if sound_data.nil?
          ''
        else
          "https://img2.tfd.com/pron/mp3/#{sound_data[0]}.mp3"
        end
      end

      def fetch_transcription(response)
        regex = %r{<span[^>]*onclick="pron_key\(1\)"[^>]*class="pron"[^>]*>\s*\(?([^)]+)\)?\s*</span>}
        transcription_data = response.body.match(regex)
        if transcription_data.nil?
          ''
        else
          decode_html_entities(transcription_data[1].force_encoding('UTF-8'))
        end
      end

      def decode_html_entities(string)
        string.gsub(/&#(\d+);/) { |_match| ::Regexp.last_match(1).to_i.chr(Encoding::UTF_8) }
      end
    end
  end
end
