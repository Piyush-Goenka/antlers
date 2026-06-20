# frozen_string_literal: true

require_relative '../interfaces/leaf_node'
require_relative '../modules/props'

module Antlers
  class PropNode < LeafNode
    include Props

    # Classes referenced via "<{ MyNode }>" must implement class/instance and render/render_template methods (See LowNode).
    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      props = evaluate_props(props: @props, current_binding:)
      event = create_render_event(props:)

      klass = class_constant(namespace: namespace&.split('::') || [], name: @name)
      instance = create_instance(klass:, event:)

      return instance.render_template(event:, parent_binding:, props:) if klass.template

      render_args(class_name: klass.to_s, instance:, event:, props:)
    end
  end
end
