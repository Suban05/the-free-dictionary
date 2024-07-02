# frozen_string_literal: true

module TheFreeDictionary
  class Italian
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'it'
        config.region = 'IT'
      end
    end
  end
end
