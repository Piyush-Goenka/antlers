# frozen_string_literal: true

require_relative 'antlers/elements'
require_relative 'antlers/lexer'
require_relative 'antlers/parser'

# These requires allow downstream libraries to build their own antlers nodes.
require_relative 'interfaces/branch_node'
require_relative 'interfaces/leaf_node'

module Antlers
  DEFAULT_ELEMENTS = [:root, :html, :form, :for, :if, :prop, :slot, :yield, :var]

  class << self
    def ast(template:, namespace: nil, elements: Elements[*DEFAULT_ELEMENTS])
      sequence = Lexer.new(lexeme_types: elements[:lexeme].to_a).parse(template:)
      Parser.new(namespace:, node_types: elements[:node].to_a).parse(sequence:)
    end

    def render(ast:, current_binding:, parent_binding: nil, slot_node: nil)
      ast.render(current_binding:, parent_binding:, slot_node:)
    end
  end
end
