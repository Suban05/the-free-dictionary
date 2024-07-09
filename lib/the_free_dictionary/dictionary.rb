# frozen_string_literal: true

module TheFreeDictionary
  class Dictionary
    attr_accessor :language, :region, :subdomain

    def find(word)
      finder = Resources::Search.new(self)
      finder.word = word
      finder.call
    end

    def word_of_day
      word_of_day = Resources::WordOfDay.new(self)
      word_of_day.call
    end
  end
end
