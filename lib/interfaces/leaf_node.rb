# frozen_string_literal: true

require_relative 'antler_node'

module Antlers
  class LeafNode < AntlerNode
    def create_instance(klass:, event:)
      # TODO: There's currently 2 results for "Lowkey[klass.to_s]", this should not be?
      param_count = Lowkey[klass.to_s].first[klass.to_s][:initialize]&.params&.count || 0

      return klass.new(event:) if param_count == 1
      return klass.new(event:, **props) if param_count > 1

      klass.new
    end

    def render_args(class_name:, instance:, event:, props:)
      param_count = Lowkey[class_name].first[class_name][:render].params.count

      return instance.render(event:) if param_count == 1
      return instance.render(event:, **props) if param_count > 1

      instance.render
    end
  end
end
