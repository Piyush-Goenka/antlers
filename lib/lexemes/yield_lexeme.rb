# frozen_string_literal: true

require_relative '../interfaces/lexeme'

module Antlers
  module YieldLexeme
    include Lexeme
    extend self

    def match?(keywords:, **)
      keywords.keys.include?(':slot')
    end

    def lexeme(**)
      { slot: :default }
    end
  end
end
