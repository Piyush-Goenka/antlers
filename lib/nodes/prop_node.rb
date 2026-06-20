# frozen_string_literal: true

require_relative '../interfaces/leaf_node'
require_relative '../modules/props'

module Antlers
  class PropNode < LeafNode
    include Props

    def render(current_binding: nil, parent_binding: nil, slot_node: nil, namespace: nil)
      props = evaluate_props(props: @props, current_binding:)
      event = create_render_event(props:)

      renderable_klass = class_constant(namespace: namespace&.split('::') || [], name: @name)
      # TODO: There's currently 2 results for "Lowkey[renderable_klass.to_s]", this should not be.
      # TODO: Only provide args that are defined, similar to how render_template does it.
      initialize_method = Lowkey[renderable_klass.to_s].first[renderable_klass.to_s][:initialize]
      renderable_instance = initialize_method ? renderable_klass.new(event:, **props) : renderable_klass.new(event:)

      # Classes referenced via "<{ ChildNode }>" must implement class/instance render/render_template methods (See LowNode).
      return renderable_instance.render_template(event:, parent_binding:, props:) if renderable_klass.template

      props.empty? ? renderable_instance.render(event:) : renderable_instance.render(event:, **props)
    end
  end
end
