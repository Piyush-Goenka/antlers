# frozen_string_literal: true

require 'low_node'

module RBX
  class SubmitFormNode < LowNode
    def render
      <{ form: }>
        <{ submit: 'Redirect Me' }>
      <{ :form }>
    end
  end
end
