# frozen_string_literal: true

module TheFreeDictionary
  class English
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'en'
        config.region = 'US'
      end
    end
  end
end
