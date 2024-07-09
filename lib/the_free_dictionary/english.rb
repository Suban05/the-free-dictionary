# frozen_string_literal: true

module TheFreeDictionary
  class English < Dictionary
    def initialize
      @language = 'en'
      @region = 'US'
      @subdomain = 'www'
    end
  end
end
