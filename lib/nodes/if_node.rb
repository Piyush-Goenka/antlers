# frozen_string_literal: true

require_relative '../interfaces/branch_node'
require_relative '../modules/props'
require_relative '../modules/variables'

module Antlers
  class IfNode < BranchNode
    include Props
    include Variables

    def initialize(name:, value:, props: [], children: [])
      super(name:, props:, children:)

      @value = value
    end

    def render(current_binding: nil, parent_binding: nil, slot_node: nil)
      output = ''.dup

      if evaluate(name: @value, current_binding:)
        @children.each do |child|
          # Antlers nodes respond to "render", whereas HTML is stored as a string and output as is.
          output += (child.respond_to?(:render) ? child.render(current_binding:, parent_binding:, slot_node:) : child) || ''
        end
      end

      output
    end
  end
end
