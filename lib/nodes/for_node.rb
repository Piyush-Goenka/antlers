# frozen_string_literal: true

require_relative '../interfaces/branch_node'
require_relative '../modules/props'
require_relative '../modules/variables'

module Antlers
  class ForNode < BranchNode
    include Props
    include Variables

    def initialize(name:, items:, value:, key: nil, props: [], children: [])
      super(name:, props:, children:)

      @items = items
      @value = value
      @key = key
    end

    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      output = ''

      evaluate(name: @items, current_binding:).each do |value|
        key, value = value if @key

        # TODO: Parallelize by creating new bindings and ensuring children have any args they need via RenderEvent.
        current_binding.local_variable_set(@value, value)
        current_binding.local_variable_set(@key, key) if @key

        @children.each do |child|
          # Antlers nodes respond to "render", whereas HTML is stored as a string and output as is.
          output += (child.respond_to?(:render) ? child.render(current_binding:, parent_binding:, slot_node:, namespace:) : child) || ''
        end
      end

      output
    end
  end
end
