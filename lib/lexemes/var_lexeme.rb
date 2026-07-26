# frozen_string_literal: true

require_relative '../interfaces/lexeme'
require_relative '../support/queries'

module Antlers
  module VarLexeme
    include Lexeme
    extend Queries
    extend self

    # Variables are special and are matched by the lexer.
    def match?(**)
      false
    end

    def lexeme(segment:, raw:, **)
      # String is already interpolated or not depending on user input on the template layer, now we store it without those template quotes.
      segment = segment[1..-2] if Queries.user_defined_string?(segment)

      return { raw_var: segment } if raw

      { var: segment }
    end
  end
end
