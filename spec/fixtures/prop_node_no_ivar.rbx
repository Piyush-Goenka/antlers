# frozen_string_literal: true

module RBX
  class PropNodeNoIvar < LowNode
    def render
      <strong>{@ivar}</strong>
    end
  end
end
