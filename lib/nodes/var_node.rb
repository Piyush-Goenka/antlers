# frozen_string_literal: true

require 'erb'

require_relative '../interfaces/leaf_node'
require_relative '../modules/variables'

module Antlers
  class VarNode < LeafNode
    include Variables

    attr_reader :value

    def initialize(value:, name: :var)
      super(name:)

      @value = value
    end

    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      ERB::Util.html_escape(evaluate_variable(name: @value, current_binding:) || @value)
    end
  end
end
