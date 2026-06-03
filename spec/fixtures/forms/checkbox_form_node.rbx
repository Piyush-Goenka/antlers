# frozen_string_literal: true

require 'low_node'

module RBX
  class CheckboxFormNode < LowNode
    def render
      <{ form: method: 'POST' }>
        <{ label: 'Test Label' }>
        <{ checkbox: 'Enabled' }>
      <{ :form }>
    end
  end
end
