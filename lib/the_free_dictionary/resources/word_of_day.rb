# frozen_string_literal: true

require 'net/http'

module TheFreeDictionary
  module Resources
    class WordOfDay < Resource
      def call
        response = fetch(build_uri(base_url))
        match = response.body.match(%r{<a href="/([^"]+)">Def[^<]+</a>})
        word = ''
        word = match[1] if match

        @dictionary.find(word).merge({ word: })
      end
    end
  end
end
