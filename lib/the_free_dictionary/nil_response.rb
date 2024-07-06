# frozen_string_literal: true

module TheFreeDictionary
  class NilResponse
    def body
      ''
    end

    def code
      '200'
    end

    def message
      'No response'
    end

    def to_s
      'Nil response'
    end
  end
end
