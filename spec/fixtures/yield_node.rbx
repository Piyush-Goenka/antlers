# frozen_string_literal: true

require 'low_node'

module RBX
  class YieldNode < LowNode
    def render
      <html>
        <{ :slot }>
      </html>
    end
  end
end
