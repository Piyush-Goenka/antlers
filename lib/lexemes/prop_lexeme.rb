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

    private

    def props(props)
      odd_props = props.join(' ').split(/(=)|\s/)

      return {} unless odd_props.any?

      props = {}
      until odd_props.empty?
        prop = odd_props.shift
        value = nil

        if odd_props.first == '='
          odd_props.shift
          value = odd_props.shift
        end

        props[prop.to_sym] = value
      end

      props
    end
  end
end
