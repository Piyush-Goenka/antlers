# frozen_string_literal: true

require 'lowload'
require 'low_node'

require_relative '../../lib/nodes/for_node'

LowLoad.lowload('spec/fixtures/for_node.rbx')

RSpec.describe RBX::ForNode do
  subject(:for_node) { described_class }

  let(:event) { 'mock event' }

  describe '#render' do
    context 'with a for loop' do
      it 'renders a list' do
        expect(RBX::ForNode.render(event:).response.body.read).to eq('<ul><li>1</li><li>2</li><li>3</li></ul>')
      end
    end
  end
end
