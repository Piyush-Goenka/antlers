# frozen_string_literal: true

require 'lowload'
LowLoad.lowload('spec/fixtures/for_array_node.rbx')

RSpec.describe RBX::ForArrayNode do
  subject(:for_node) { described_class }

  describe '<{ for: value in: @items }>' do
    it 'renders value' do
      expect(RBX::ForArrayNode.render(event: 'asdf').response.body.read).to eq(
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
