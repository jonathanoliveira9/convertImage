require 'rmagick'
include Magick

module ConvertImage
  class Convert
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def to_jpeg
      f = ImageList.new('kuma.png')
      f.write('kuma.jpeg')
      Tempfile
    end

    def to_png
    end

    def to_jpg
    end
  end
end
