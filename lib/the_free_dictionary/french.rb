# frozen_string_literal: true

module TheFreeDictionary
  class French
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'fr'
        config.region = 'EU'
      end
    end
  end
end
