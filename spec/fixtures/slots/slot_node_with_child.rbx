# frozen_string_literal: true

require 'low_node'
require_relative '../../../lib/antlers'

module RBX
  class SlotNodeWithChild < LowNode
    def initialize
      @ivar = 'Parent Variable'
    end

    def render
      <{ LayoutNode: }>
        <{ PropNodeVar var=@ivar }>
      <{ :LayoutNode }>
    end
  end
end
