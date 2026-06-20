# frozen_string_literal: true

require 'low_node'

class LayoutNode < LowNode
  def render
    <html class="without-namespace">
      <{ :slot }>
    </html>
  end
end
