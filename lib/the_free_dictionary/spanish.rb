# frozen_string_literal: true

module TheFreeDictionary
  class Spanish
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'es'
        config.region = /(EU|LA)/
      end
    end
  end
end
