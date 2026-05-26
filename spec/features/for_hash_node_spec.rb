# frozen_string_literal: true

require 'lowload'
require 'low_node'

require_relative '../../lib/nodes/for_node'

LowLoad.lowload('spec/fixtures/for_hash_node.rbx')

RSpec.describe RBX::ForHashNode do
  subject(:for_node) { described_class }

  let(:event) { 'mock event' }

  describe '<{ for: key, value in: @items }>' do
    it 'renders items' do
      expect(RBX::ForHashNode.render(event:).response.body.read).to eq(
        <<~HTML.delete(" \n")
          <ul>
            <li>one:1</li>
            <li>two:2</li>
            <li>three:3</li>
          </ul>
        HTML
      )
    end
  end
end
