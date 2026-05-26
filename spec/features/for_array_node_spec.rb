# frozen_string_literal: true

require 'lowload'
require 'low_node'

require_relative '../../lib/nodes/for_node'

LowLoad.lowload('spec/fixtures/for_array_node.rbx')

RSpec.describe RBX::ForArrayNode do
  subject(:for_node) { described_class }

  let(:event) { 'mock event' }

  describe '<{ for: value in: @items }>' do
    it 'renders value' do
      expect(RBX::ForArrayNode.render(event:).response.body.read).to eq(
        <<~HTML.delete(" \n")
          <ul>
            <li>1</li>
            <li>2</li>
            <li>3</li>
          </ul>
        HTML
      )
    end
  end
end
