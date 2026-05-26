module Antlers
  module Variables
    # A variable is deliberately limited in what it can represent.
    #  1. An instance variable
    #  2. A method call/local variable
    #  3. A static string
    def evaluate_variable(name:, current_binding:)
      if current_binding
        return current_binding.receiver.instance_variable_get(name) if name.start_with?('@')
        return current_binding.local_variable_get(name) if current_binding.local_variable_defined?(name)
        return current_binding.receiver.send(name.to_sym) if current_binding.receiver.respond_to?(name.to_sym)
      end

      @value.to_s
    rescue NameError
      @value.to_s
    end
  end
end
