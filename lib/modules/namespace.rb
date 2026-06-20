# frozen_string_literal: true

module Antlers
  module Namespace
    def class_constant(namespace:, name:)
      return Object.const_get(name) if name.start_with?('::')

      class_from_namespace(namespace:, name:)
    end

    def class_from_namespace(namespace:, name:)
      namespace_with_name = [namespace, name].join('::')
      return Object.const_get(namespace_with_name) if Object.const_defined?(namespace_with_name)

      namespace.pop
      class_from_namespace(namespace:, name:)
    end
  end
end
