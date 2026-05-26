# frozen_string_literal: true

require 'low_node'

module RBX
  class ForHashNode < LowNode
    def initialize(event:)
      @items = {
        one: 1,
        two: 2,
        three: 3,
      }
    end

    def render(event:)
      <ul>
        <{ for: key, value in: @items }>
          <li>{key}:{value}</li>
        <{ :for }>
      </ul>
    end
  end
end
