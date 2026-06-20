# frozen_string_literal: true

require 'low_node'

module Namespace
  class LayoutNode < LowNode
    def render
      <html class="with-namespace">
        <{ :slot }>
      </html>
    end
  end
end
