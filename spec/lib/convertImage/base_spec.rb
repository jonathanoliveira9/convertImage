# frozen_string_literal: true

RSpec.describe ConvertImage::Base do
  let(:instance) { described_class }

  it { expect(described_class).to eq(ConvertImage::Base) }
  it { expect { instance.new('').to_jpg }.to raise_error(NotImplementedError) }
  it { expect { instance.new('').to_jpeg }.to raise_error(NotImplementedError) }
  it { expect { instance.new('').to_png }.to raise_error(NotImplementedError) }
end
