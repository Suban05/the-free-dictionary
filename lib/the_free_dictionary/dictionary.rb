# frozen_string_literal: true

require "net/http"

module TheFreeDictionary
  class Dictionary
    attr_accessor :statement, :http_module, :hostname, :language, :region

    def initialize
      @http_module = Net::HTTP
    end

    def self.find
      dictionary = new
      yield dictionary if block_given?

      uri = URI(URI::Parser.new.escape("https://#{dictionary.language}.thefreedictionary.com/#{dictionary.statement}"))
      begin
        response = dictionary.http_module.get_response(uri)
        audio_data = response.body.match(/#{dictionary.language}\/#{dictionary.region}[^"]+/)
        transcription_data = response.body.match(/<span[^>]*onclick="pron_key\(1\)"[^>]*class="pron"[^>]*>\s*\(?([^)]+)\)?\s*<\/span>/)
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

    def self.decode_html_entities(string)
      string.gsub(/&#(\d+);/) { |match| $1.to_i.chr(Encoding::UTF_8) }
    end
  end
end
