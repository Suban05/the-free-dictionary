# frozen_string_literal: true

module TheFreeDictionary
  class Spanish < Dictionary
    def initialize
      @language = 'es'
      @region = /(EU|LA)/
    end
  end
end
