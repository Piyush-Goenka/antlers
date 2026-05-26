# frozen_string_literal: true

require_relative '../lib/antlers'

RSpec.describe Antlers do
  subject(:antlers) { described_class }

  describe '.ast' do
    before do
      allow(Antlers::Parser).to receive(:parse)
    end

    it 'calls parser' do
      Antlers.ast('<{ MockNode }>')

      expect(Antlers::Parser).to have_received(:parse)
    end
  end
end
