# frozen_string_literal: true

module TheFreeDictionary
  class German
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'de'
        config.region = 'DE'
      end
    end
  end
end
