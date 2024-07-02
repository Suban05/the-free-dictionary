# frozen_string_literal: true

module TheFreeDictionary
  class Chinese
    def find(statement)
      TheFreeDictionary::Dictionary.find do |config|
        config.statement = statement
        config.language = 'zh'
        config.region = 'CN'
      end
    end
  end
end
