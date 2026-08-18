# frozen_string_literal: true

require 'low_node'
require_relative '../../../lib/antlers'

module RBX
  class SlotNodeWithProp < LowNode
    def render
      <{ LayoutNodeWithProp: emotion='Happy' }>
        {"Yield"}
      <{ :LayoutNodeWithProp }>
    end
  end
end
