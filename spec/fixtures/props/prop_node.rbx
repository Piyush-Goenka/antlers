# frozen_string_literal: true

require 'low_node'

module RBX
  class PropNode < LowNode
    def initialize
      @ivar = 'Instance Variable'
    end

    def render
      <html>{@ivar}</html>
    end
  end
end
