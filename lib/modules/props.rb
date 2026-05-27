# frozen_string_literal: true

require 'low_event'
require_relative 'variables'

module Antlers
  module Props
    include Variables

    attr_accessor :props

    def initialize(name:, props: {}, **)
      super(name:, **)

      @props = props
    end

    private

    def create_render_event(props:)
      Low::Events::RenderEvent.new(action: :render, props:)
    end

    def evaluate_props(props:, current_binding:)
      return {} if props.nil?

      evaluated_props = {}

      props.each do |name, value|
        evaluated_props[name] = evaluate(name: value, current_binding:) || fallback(value)
      end

      evaluated_props
    end

    def class_from_namespace(namespace:, name:)
      return Object.const_get(name) if Object.const_defined?(name) || name.start_with?('::') || namespace.empty?

      namespace_with_name = [namespace, name].join('::')
      return Object.const_get(namespace_with_name) if Object.const_defined?(namespace_with_name)

      namespace.pop
      class_from_namespace(namespace:, name:)
    end
  end
end
