# frozen_string_literal: true

module TheFreeDictionary
  class Russian
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'ru'
        config.region = 'RU'
      end
    end
  end
end
