# frozen_string_literal: true

require "net/http"

module TheFreeDictionary
  class Dictionary
    attr_accessor :language, :region

    def find(statement)
      uri = build_uri(statement)
      begin
        response = Net::HTTP.get_response(uri)
        audio_data = find_audio_data(response)
        transcription_data = find_transcription_data(response)
      rescue Socket::ResolutionError
        audio_data = nil
        transcription_data = nil
      end
      if audio_data.nil?
        sound = ""
      else
        sound = "https://img2.tfd.com/pron/mp3/#{audio_data[0]}.mp3"
      end

      if transcription_data.nil?
        transcription = ""
      else
        transcription = decode_html_entities(transcription_data[1].force_encoding("UTF-8"))
      end
      { sound:, transcription: }
    end

    private

    def build_uri(statement)
      URI(URI::Parser.new.escape("https://#{@language}.thefreedictionary.com/#{statement}"))
    end

    def find_audio_data(response)
      response.body.match(/#{@language}\/#{@region}[^"]+/)
    end

    def find_transcription_data(response)
      response.body.match(/<span[^>]*onclick="pron_key\(1\)"[^>]*class="pron"[^>]*>\s*\(?([^)]+)\)?\s*<\/span>/)
    end

    def decode_html_entities(string)
      string.gsub(/&#(\d+);/) { |match| $1.to_i.chr(Encoding::UTF_8) }
    end
  end
end
