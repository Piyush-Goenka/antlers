# frozen_string_literal: true

require_relative '../interfaces/branch_node'
require_relative '../modules/props'
require_relative '../modules/variables'

module Antlers
  class FormNode < BranchNode
    include Props
    include Variables

    def initialize(name:, action: nil, method: 'POST', props: [], children: [])
      super(name:, props:, children:)

      @action = action
      @method = method
    end

    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      output = "<form action='#{@action}' method='#{@method}'>"

      @children.each do |child|
        # Antlers nodes respond to "render", whereas HTML is stored as a string and output as is.
        output += (child.respond_to?(:render) ? child.render(current_binding:, parent_binding:, slot_node:, namespace:) : child) || ''
      end

      output += '</form>'
      output
    end
  end
end
