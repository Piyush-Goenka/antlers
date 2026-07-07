# frozen_string_literal: true

require_relative '../interfaces/lexeme'

module Antlers
  module FormLexeme
    include Lexeme
    extend self

    KEYWORDS = ['form:', ':form'].freeze

    def match?(keywords:, **)
      KEYWORDS.include?(keywords.keys.first)
    end

    def lexeme(keywords:, **)
      if keywords.key?('form:')
        action = keywords['form:'] ? keywords['form:'][1...-1] : nil
        return { form_def: action }
      end

      { form_end: 'level_1' }
    end
  end
end
