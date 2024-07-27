# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

module TheFreeDictionary
  module Resources
    class WordOfDay < Resource
      def call
        response = fetch(build_uri(base_url))
        doc = nokogiri(response.body)
        word = find_word(doc)
        definition = find_definition(doc)
        synonyms = find_synonyms(doc)
        usage = find_usage(doc)
        @dictionary.find(word).merge({ word:, definition:, synonyms:, usage: })
      end

      private

      def nokogiri(string)
        html = string.split('<div id="Content_CA_WOD_0_BC"')[1]
        Nokogiri::HTML(html, nil, 'UTF-8')
      end

      def find_word(nokogiri)
        find_content(nokogiri, '//h3/a')
      end

      def find_definition(nokogiri)
        find_content(nokogiri, '//tr[1]/td[2]')
      end

      def find_synonyms(nokogiri)
        find_content(nokogiri, '//tr[2]/td[2]')
      end

      def find_usage(nokogiri)
        find_content(nokogiri, '//tr[3]/td[2]').sub(/\r\n Discuss\. Play$/, '')
      end

      def find_content(nokogiri, expression)
        nokogiri.at_xpath(expression).text.strip
      end
    end
  end
end
