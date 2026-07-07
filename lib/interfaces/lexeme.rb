# frozen_string_literal: true

module Antlers
  module Lexeme
    KEYWORDS = []

    def match?(name: nil, keywords: {}) = false

    def lexeme(name:, props:, keywords:)
      raise NotImplementedError
    end
  end
end
