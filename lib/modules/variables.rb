module Antlers
  module Variables
    # A variable is deliberately limited in what it can represent.
    #  1. An instance variable
    #  2. A method call/local variable
    #  3. A method chain
    #  4. A static string
    def evaluate_variable(name:, current_binding:)
      name, *chain = name.split('.')

      result = evaluate(name:, current_binding:)
      return method_chain(result:, chain:, current_binding:) if chain.count > 0
      return result if result

      @value.to_s
    rescue NameError
      @value.to_s
    end

    private

    def evaluate(name:, current_binding:)
      if current_binding
        return current_binding.receiver.instance_variable_get(name) if name.start_with?('@')
        return current_binding.local_variable_get(name) if current_binding.local_variable_defined?(name)
        return current_binding.receiver.send(name.to_sym) if current_binding.receiver.respond_to?(name.to_sym)
      end
    end

    def method_chain(result:, chain:, current_binding:)
      chain.reduce(result) do |result, method_call|
        result = result.send(method_call.to_sym)
      end
    end
  end
end
