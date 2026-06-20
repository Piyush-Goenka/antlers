# frozen_string_literal: true

require 'low_node'

module Ruby
  class PropNode < LowNode
    def initialize
      @ivar = 'Instance Variable'
    end

    def render
      @ivar
    end
  end
end
