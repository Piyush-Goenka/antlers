# frozen_string_literal: true

require_relative '../interfaces/branch_node'
require_relative '../modules/props'

module Antlers
  class ForNode < BranchNode
    include Props

    attr_accessor :children

    def initialize(name:, item:, items:, props: [], children: [])
      super(name:, props:, children:)

      @item = item
      @items = items
    end

    def render
      'yes'
    end
  end
end
