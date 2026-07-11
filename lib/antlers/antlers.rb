# frozen_string_literal: true

require_relative 'lexer'
require_relative 'parser'

module Antlers
  class << self
    def ast(template:, namespace: nil, node_types: nil)
      return template unless template.include?('<{') || template.include?('{')

      sequence = Lexer.new.parse(template)

      Parser.new(namespace:, node_types:).parse(sequence:)
    end

    def render(ast:, current_binding:, parent_binding: nil, slot_node: nil)
      ast.render(current_binding:, parent_binding:, slot_node:)
    end
  end
end
