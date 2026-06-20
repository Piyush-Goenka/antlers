# frozen_string_literal: true

require 'lowload'

require_relative '../../lib/nodes/prop_node'
require_relative '../fixtures/prop_node'
LowLoad.lowload('spec/fixtures/prop_node.rbx')

# Render an Antlers node, which renders its corresponding named LowNode, which renders its Antlers template.
RSpec.describe Antlers::PropNode do
  describe '#render' do
    subject(:prop_node) { described_class.new(name: 'RBX::PropNode') }

    it 'renders an instance variable' do
      expect(prop_node.render).to eq('<html>Instance Variable</html>')
    end

    context 'when low node is plain Ruby' do
      subject(:prop_node) { described_class.new(name: 'Ruby::PropNode') }

      it 'renders an instance variable' do
        expect(prop_node.render).to eq('Instance Variable')
      end
    end
  end
end
