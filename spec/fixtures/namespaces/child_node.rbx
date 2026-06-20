# frozen_string_literal: true

require 'low_node'

class ChildNode < LowNode
  def render
    <{ LayoutNode: }>
      <p></p>
    <{ :LayoutNode }>
  end
end
