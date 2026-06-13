# frozen_string_literal: true

require_relative 'support/queries'

module Antlers
  extend Queries

  class LexerParseError < StandardError; end

  class Lexer
    def initialize
      @delimiters = ['<{', '}>', '{', '}']
      @keywords = ['if:', 'for:', 'in:', ':for', 'slot:', ':slot']
      @cursor = 0
    end

    def parse(template)
      @cursor = 0
      sequence = []

      # Split on delimiters and retain capture groups.
      segments = template.split(/(#{Regexp.union(@delimiters)})/).map(&:strip)

      until segments[@cursor].nil?
        if (antlers_segment = antlers_segment(segments:))
          sequence << antlers_lexeme(antlers_segment:, segments:)
          # Skipping: ['{', 'expression', '}']
          # Skipping: ['<{', 'name + props + keywords', '}>']
          @cursor += 3
        else
          segment = segments[@cursor]
          sequence << segment unless segment.empty?
          @cursor += 1
        end
      end

      sequence
    end

    private

    def antlers_segment(segments:)
      next_segment = segments[@cursor + 1]
      return nil unless next_segment && (segments[@cursor] == '<{' || var?(segments:))

      next_segment
    end

    def antlers_lexeme(antlers_segment:, segments:)
      return var(antlers_segment:) if var?(segments:)

      name, props, keywords = parse_segment(antlers_segment:)

      return slot_yield if slot_yield?(keywords:)
      return slot(name:, props:) if slot?(name)
      return prop(name:, props:) if prop?(name)
      return for_loop(keywords:) if for_loop?(keywords:)

      raise LexerParseError, "Unrecognised syntax: '#{antlers_segment}'"
    end

    def parse_segment(antlers_segment:)
      name_and_props, *keywords = antlers_segment.split(/(#{Regexp.union(@keywords)})/)
      name, *props = name_and_props.split(' ')
      [name, props, parse_keywords(keywords:)]
    end

    def parse_keywords(keywords:)
      key_values = {}

      while (keyword = keywords.shift)
        keyword.strip!
        value = keyword.end_with?(':') && value?(keywords.first) ? keywords.shift.strip : nil
        key_values[keyword] = value
      end

      key_values
    end

    def value?(string)
      !(string.start_with?(':') || string.end_with?(':'))
    end

    def var?(segments:)
      first, _, last = segments[@cursor..@cursor + 3].map(&:strip)
      first == '{' && last == '}'
    end

    def for_loop?(keywords:)
      ['for:', ':for'].include?(keywords.first)
    end

    def slot?(name)
      name && (name.start_with?(':') || name.end_with?(':'))
    end

    def slot_yield?(keywords:)
      keywords.keys.include?(':slot')
    end

    def prop?(name)
      name && [*'A'..'Z'].include?(name[0])
    end

    def var(antlers_segment:)
      # String is already interpolated or not depending on user input on the template layer, now we store it without those template quotes.
      antlers_segment = antlers_segment[1..-2] if Queries.user_defined_string?(antlers_segment)

      { var: antlers_segment }
    end

    def for_loop(keywords:)
      if keywords['for:']
        *key, value = keywords['for:'].split(',').map(&:strip)
        for_def = { for_def: value, in: keywords['in:'] }
        for_def[:key] = key.first unless key.empty?
        return for_def
      end

      # TODO: Keep track of which for loop we're in to allow nested for loops.
      { for_end: 'level_1' }
    end

    def slot(name:, props:)
      if name.end_with?(':')
        slot_def = { slot_def: name.delete_suffix(':') }
        slot_def[:props] = props(props) unless props.empty?
        return slot_def
      end

      { slot_end: name.delete_prefix(':') }
    end

    def slot_yield
      { slot: :default }
    end

    def prop(name:, props:)
      prop = { prop: name }
      prop[:props] = props(props) unless props.empty?
      prop
    end

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
