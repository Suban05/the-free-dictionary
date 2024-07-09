# frozen_string_literal: true

require 'net/http'

module TheFreeDictionary
  module Resources
    class Resource
      attr_reader :dictionary

      def initialize(dictionary)
        @dictionary = dictionary
      end

      private

      def fetch(uri)
        Net::HTTP.get_response(uri)
      rescue Socket::ResolutionError
        TheFreeDictionary::NilResponse.new
      end

      def build_uri(url)
        URI(URI::DEFAULT_PARSER.escape(url))
      end

      def base_url
        "https://#{@dictionary.subdomain || @dictionary.language}.#{host}"
      end

      def host
        'thefreedictionary.com'
      end
    end
  end
end
