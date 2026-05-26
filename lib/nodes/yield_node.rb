# frozen_string_literal: true

require_relative '../interfaces/leaf_node'

module Antlers
  class YieldNode < BranchNode
    def initialize(name: :default)
      super(name:)
    end

    # Renders the children of the parent node in the binding of the parent.
    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      output = ''

      slot_node.children.each do |child|
        # Antlers nodes respond to "render", whereas HTML is stored as a string and output as is.
        if child.respond_to?(:render) # rubocop:disable Style/ConditionalAssignment
          output += child.render(current_binding: parent_binding, parent_binding: nil, slot_node: nil, namespace:)
        else
          output += child || ''
        end
      end

      output
    end
  end
end
