# frozen_string_literal: true

module TheFreeDictionary
  class Chinese < Dictionary
    def initialize
      @language = 'zh'
      @region = 'CN'
    end
  end
end
