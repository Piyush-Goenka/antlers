# frozen_string_literal: true

require 'low_node'

module RBX
  class BasicFormNode < LowNode
    def render
      <{ form: '/submit' }>
        <button>Submit</button>
      <{ :form }>
    end
  end
end
