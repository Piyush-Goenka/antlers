# frozen_string_literal: true

require 'low_node'

module RBX
  class ForNode < LowNode
    def initialize(event:)
      @items = [1, 2, 3]
    end

    def render(event:)
      <ul>
        <{ for: item in: @items }>
          <li>{item}</li>
        <{ :for }>
      </ul>
    end
  end
end
