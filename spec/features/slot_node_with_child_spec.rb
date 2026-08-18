# frozen_string_literal: true

require_relative '../../lib/nodes/prop_node'
require_relative '../../lib/nodes/slot_node'

LowLoad.lowload('spec/fixtures/slots/slot_node_with_child.rbx')
LowLoad.lowload('spec/fixtures/props/prop_node_var.rbx')
LowLoad.lowload('spec/fixtures/layout_node.rbx')

RSpec.describe RBX::SlotNodeWithChild do
  subject(:parent_node) { described_class }

  let(:namespace) { 'RBX::SlotNodeWithChild' }

  describe '#render' do
    context 'when slot has a prop node' do
      subject(:slot_node) { Antlers::SlotNode.new(name: 'RBX::LayoutNode', children: [prop_node], namespace:) }
      subject(:prop_node) { Antlers::PropNode.new(name: 'RBX::PropNodeVar', namespace:) }

      it 'renders both slot and prop node' do
        expect(parent_node.render.response.body.read).to eq('<html><strong>Parent Variable</strong></html>')
      end
    end
  end
end
