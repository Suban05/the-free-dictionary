# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

module TheFreeDictionary
  module Resources
    class WordOfDay < Resource
      def call
        response = fetch(build_uri(base_url))
        html = response.body.split("<div id=\"Content_CA_WOD_0_BC\"")[1]
        doc = Nokogiri::HTML(html, nil, 'UTF-8')
        word = doc.at_xpath('//h3/a').text.strip
        definition = doc.at_xpath('//tr[1]/td[2]').text.strip
        synonyms = doc.at_xpath('//tr[2]/td[2]').text.strip
        usage = doc.at_xpath('//tr[3]/td[2]').text.strip.sub(/\r\n Discuss\. Play$/, '')
        @dictionary.find(word).merge({ word:, definition:, synonyms:, usage: })
      end
    end
  end
end
