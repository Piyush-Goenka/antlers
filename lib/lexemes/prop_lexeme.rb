# frozen_string_literal: true

require_relative '../interfaces/lexeme'

module Antlers
  module PropLexeme
    include Lexeme
    extend self

    def match?(name:, **)
      name && [*'A'..'Z'].include?(name[0]) && !(name.start_with?(':') || name.end_with?(':'))
    end

    def lexeme(name:, props:, **)
      prop = { prop: name }
      prop[:props] = props(props) unless props.empty?
      prop
    end
  end
end
