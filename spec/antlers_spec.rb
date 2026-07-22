# frozen_string_literal: true

require_relative '../lib/antlers'

RSpec.describe Antlers do
  subject(:antlers) { described_class }

  describe '.ast' do
    let(:parser) { Antlers::Parser.new(node_types: []) }

    before do
      allow(Antlers::Parser).to receive(:new).and_return(parser)
      allow(parser).to receive(:parse)
    end

    it 'calls parser' do
      Antlers.ast(template: '<{ MockNode }>')

      expect(parser).to have_received(:parse)
    end
  end
end
