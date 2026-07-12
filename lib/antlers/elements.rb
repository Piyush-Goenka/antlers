# frozen_string_literal: true

module Antlers
  module Elements
    extend self

    def [](*elements, namespace: '::Antlers')
      ElementSet.new(elements: elements.map { |name|
        name = name.to_s
        lexeme_type = class_reference(name:, namespace:, class_type: 'Lexeme')
        node_type = class_reference(name:, namespace:, class_type: 'Node')

        Element.new(lexeme_type:, node_type:)
      })
    end

    class Element
      attr_reader :lexeme_type, :node_type

      def initialize(lexeme_type:, node_type:)
        @lexeme_type = lexeme_type
        @node_type = node_type
      end
    end

    class ElementSet
      def initialize(elements:)
        @elements = elements
      end

      def lexeme_types
        @elements.map { |e| e.lexeme_type }.compact
      end

      def node_types
        @elements.map { |e| e.node_type }.compact
      end
    end

    private

    def class_reference(name:, namespace:, class_type:)
      [name.capitalize, name.upcase].each do |n|
        class_name = [namespace, "#{n}#{class_type}"].join('::')

        return Object.const_get(class_name) if Object.const_defined?(class_name)
      end

      nil
    end
  end
end
