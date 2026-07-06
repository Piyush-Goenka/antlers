# frozen_string_literal: true

require 'lowload'
require_relative '../../../lib/nodes/if_node'

LowLoad.lowload('spec/fixtures/ifs/if_node.rbx')

RSpec.describe RBX::IfNode do
  subject(:if_node) { described_class.render(event: nil, boolean:) }

  describe '<{ if: }>' do
    context 'when true' do
      let(:boolean) { true }

      it 'renders children' do
        expect(if_node.response.body.read).to eq(
          <<~HTML.squish
            <p>Yes</p>
          HTML
        )
      end
    end

    context 'when false' do
      let(:boolean) { false }

      it 'renders empty string' do
        expect(if_node.response.body.read).to eq('')
      end
    end
  end
end
