# frozen_string_literal: true

require_relative '../support/queries'

module Antlers
  extend Queries

  class LexerError < StandardError; end

  class Lexer
    def initialize(lexeme_types:)
      @delimiters = ['<{', '}>', '{', '}']
      @lexeme_types = lexeme_types
      @keywords = @lexeme_types.flat_map { |lexeme| lexeme.const_get(:KEYWORDS) }
      @cursor = 0
    end

    def parse(template:)
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
      return nil unless next_segment && (segments[@cursor] == '<{' || brackets?(segments:))

      next_segment
    end

    def antlers_lexeme(antlers_segment:, segments:)
      return var(antlers_segment:) if brackets?(segments:)

      name, props, keywords = parse_segment(antlers_segment:)

      lexeme = @lexeme_types.find { it.match?(name:, keywords:) }
      return lexeme.lexeme(name:, props:, keywords:) if lexeme
      return var(antlers_segment:, raw: true) if deerheads?(segments:)

      raise LexerError, "Unrecognised syntax: '#{antlers_segment}'"
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
        value = keyword.end_with?(':') && value?(keywords.first.strip) ? keywords.shift.strip : nil
        key_values[keyword] = value
      end

      key_values
    end

    def value?(string)
      !(string.start_with?(':') || string.end_with?(':'))
    end

    # TODO: Refactor every constant, match and result method into its own class. Loop through every class and return the first match.

    def brackets?(segments:)
      first, _, last = segments[@cursor..@cursor + 3].map(&:strip)
      first == '{' && last == '}'
    end

    def deerheads?(segments:)
      first, _, last = segments[@cursor..@cursor + 3].map(&:strip)
      first == '<{' && last == '}>'
    end

    def var(antlers_segment:, raw: false)
      # String is already interpolated or not depending on user input on the template layer, now we store it without those template quotes.
      antlers_segment = antlers_segment[1..-2] if Queries.user_defined_string?(antlers_segment)

      return { raw_var: antlers_segment } if raw

      { var: antlers_segment }
    end
  end
end
