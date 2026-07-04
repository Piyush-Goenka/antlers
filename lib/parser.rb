# frozen_string_literal: true

require_relative 'factories/node_factory'
require_relative 'nodes/root_node'

module Antlers
  class Parser
    def initialize(namespace: nil)
      @factory = NodeFactory.new(namespace:)
    end

    def parse(sequence:, id: :root_node)
      branch(node: RootNode.new(name: id), sequence:)
    end

    def branch(node:, sequence:) # rubocop:disable Metrics/AbcSize
      until sequence.empty?
        segment = sequence.shift

        if segment.is_a?(String)
          node.children << segment
        elsif segment[:var]
          node.children << @factory.var_node(segment:)
        elsif segment[:raw_var]
          node.children << @factory.raw_var_node(segment:)
        elsif segment[:prop]
          node.children << @factory.prop_node(segment:)
        elsif segment[:slot]
          node.children << @factory.yield_node(segment:)
        elsif segment[:slot_def]
          slot_node = @factory.slot_node(segment:)
          node.children << slot_node
          sub_branch(node: slot_node, sequence:, end_key: :slot_end, end_name: slot_node.name)
        elsif segment[:for_def]
          for_node = @factory.for_node(segment:)
          node.children << for_node
          sub_branch(node: for_node, sequence:, end_key: :for_end, end_name: 'level_1')
        elsif segment[:form_def]
          form_node = @factory.form_node(segment:)
          node.children << form_node
          sub_branch(node: form_node, sequence:, end_key: :form_end, end_name: 'level_1')
        end
      end

      node
    end

    def sub_branch(node:, sequence:, end_key:, end_name: nil)
      sub_sequence = []
      sub_sequence << sequence.shift until sequence.first.is_a?(Hash) && sequence.first[end_key] == end_name

      branch(node:, sequence: sub_sequence)
    end
  end
end
