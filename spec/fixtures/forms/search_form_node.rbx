# frozen_string_literal: true

require 'low_node'

module RBX
  class SearchFormNode < LowNode
    def render
      <{ form: '/search' method: 'GET' }>
        <{ label: 'Test Label' }>
        <{ search: :query }>
        <{ submit: 'Search' }>
      <{ :form }>
    end
  end
end
