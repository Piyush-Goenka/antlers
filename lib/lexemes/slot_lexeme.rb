# frozen_string_literal: true

require_relative '../interfaces/lexeme'

module Antlers
  module SlotLexeme
    include Lexeme
    extend self

    KEYWORDS = ['slot:', ':slot'].freeze

    def match?(name:, **)
      name && (name.start_with?(':') || name.end_with?(':'))
    end

    def lexeme(name:, props:, **)
      if name.end_with?(':')
        slot_def = { slot_def: name.delete_suffix(':') }
        slot_def[:props] = props(props) unless props.empty?
        return slot_def
      end

      { slot_end: name.delete_prefix(':') }
    end
  end
end
