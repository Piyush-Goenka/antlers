# frozen_string_literal: true

require_relative '../nodes/root_node'
require_relative '../nodes/if_node'
require_relative '../nodes/for_node'
require_relative '../nodes/form_node'
require_relative '../nodes/html_node'
require_relative '../nodes/prop_node'
require_relative '../nodes/slot_node'
require_relative '../nodes/var_node'
require_relative '../nodes/yield_node'

module Antlers
  ANTLERS_NODES = [
    HTMLNode, # Match strings early.
    IfNode,
    ForNode,
    FormNode,
    PropNode,
    SlotNode,
    VarNode,
    YieldNode,
  ]
end
