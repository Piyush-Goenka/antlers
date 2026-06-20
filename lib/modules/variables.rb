# frozen_string_literal: true

require_relative '../support/queries'

module Antlers
  module Variables
    extend Queries

    # Evaluation limited to the following for security and to prevent a templating language becoming a programming language.
    #  1. An instance variable
    #  2. A method call/local variable
    #  3. A method chain
    #  4. A static string
    def evaluate(name:, current_binding:)
      return name.to_s unless current_binding

      name, *chain = name.split('.')

      result = method_var(name:, current_binding:)
      return method_chain(result:, chain:, current_binding:) if chain.count > 0
      return result if result

      nil
    rescue StandardError
      nil
    end

    def fallback(value)
      return value[1..-2] if Queries.user_defined_string?(value)

      value
    end

    private

    def method_var(name:, current_binding:)
      return current_binding.receiver.instance_variable_get(name) if name.start_with?('@')
      return current_binding.local_variable_get(name) if current_binding.local_variable_defined?(name)
      return current_binding.receiver.send(name.to_sym) if current_binding.receiver.respond_to?(name.to_sym)

      nil
    end

    def method_chain(result:, chain:, current_binding:)
      chain.reduce(result) do |result, method_call|
        result.send(method_call.to_sym)
      end
    end
  end
end
