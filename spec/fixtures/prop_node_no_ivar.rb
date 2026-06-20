# frozen_string_literal: true

module Ruby
  class PropNodeNoIvar < LowNode
    def render
      @ivar
    end
  end
end
