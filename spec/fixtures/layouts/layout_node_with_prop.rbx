# frozen_string_literal: true

require 'low_node'

module RBX
  class LayoutNodeWithProp < LowNode
    def render(event:, emotion:)
      <html>
        {"Layout"}
        {emotion}
        <{ :slot }>
      </html>
    end
  end
end
