# frozen_string_literal: true

require_relative '../../lib/antlers/elements'
require_relative '../../lib/antlers/parser'

RSpec.describe 'Antlers::Parser: Form' do
  subject(:parser) { Antlers::Parser.new(node_types:) }

  let(:node_types) { Antlers::Elements[:html, :form, :for][:node].to_a }

  context 'with basic form' do
    let(:sequence) do
      [{ form_def: '/submit' }, '<button>Submit</button>', { form_end: 'level_1' }]
    end

    let(:form_node) do
      Antlers::FormNode.new(name: 'FormNode', action: '/submit', children: ['<button>Submit</button>'])
    end

    it 'returns AST' do
      expect(parser.parse(sequence:).children).to eq([form_node])
    end
  end
end
