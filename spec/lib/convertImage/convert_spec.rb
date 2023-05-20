RSpec.describe ConvertImage::Convert do
  let(:instance) { described_class }
  let(:file) { '' }
  let(:result) { instance.new(file) }
  it { expect(instance).to eq(ConvertImage::Convert) }

  describe '.to_jpeg' do
    context 'when file is png' do
      let(:file) { File.open('spec/support/images/image.png') }

      it { expect(result.to_jpeg.class).to eq(File) }
    end
  end
end
