# frozen_string_literal: true

require_relative '../nodes/root_node'
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
  class Parser
    class ParserError < StandardError; end

    def initialize(namespace: nil, node_types: nil)
      @namespace = namespace
      @node_types = node_types || ELEMENTS.node_types
    end

    def parse(sequence:, id: :root_node)
      branch(node: RootNode.new(name: id), sequence:)
    end

    def branch(node:, sequence:)
      until sequence.empty?
        segment = sequence.shift

        child_class = @node_types.find { |n| n.match?(segment:) }
        raise(ParserError, "No node matches #{segment}") unless child_class

        child = child_class.build(segment:, namespace: @namespace)
        node.children << child

        if (end_key = child_class::END_KEY)
          sub_branch(node: child, sequence:, end_key:, end_name: child.end_name)
        end
      end

      node
    end

    def sub_branch(node:, sequence:, end_key:, end_name: nil)
      sub_sequence = []
      sub_sequence << sequence.shift until sequence.first.is_a?(Hash) && sequence.first[end_key] == end_name
      # Remove the end tag we just stopped before.
      sequence.shift

      branch(node:, sequence: sub_sequence)
    end
  end
end
