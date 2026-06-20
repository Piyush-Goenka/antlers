# frozen_string_literal: true

require 'low_node'

module RBX
  class ForNodeArray < LowNode
    def initialize
      @items = [1, 2, 3]
    end

    def render
      <ul>
        <{ for: item in: @items }>
          <li>{item}</li>
        <{ :for }>
      </ul>
    end
  end
end
