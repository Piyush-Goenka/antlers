# frozen_string_literal: true

require_relative 'antlers/elements'
require_relative 'antlers/lexer'
require_relative 'antlers/parser'

# These requires allow downstream libraries to build their own antlers nodes.
require_relative 'interfaces/branch_node'
require_relative 'interfaces/leaf_node'

module Antlers
  ELEMENTS = Elements[:html, :form, :for, :if, :prop, :slot, :yield, :var]

  class << self
    def ast(template:, namespace: nil, elements: nil)
      return template unless template.include?('<{') || template.include?('{')

      elements ||= ELEMENTS

      sequence = Lexer.new(lexeme_types: elements.lexeme_types).parse(template:)
      Parser.new(namespace:, node_types: elements.node_types).parse(sequence:)
    end

    def render(ast:, current_binding:, parent_binding: nil, slot_node: nil)
      ast.render(current_binding:, parent_binding:, slot_node:)
    end
  end
end
