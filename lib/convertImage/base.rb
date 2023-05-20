# frozen_string_literal: true

require 'rmagick'
include Magick


module ConvertImage

  class Base
    attr_reader :file

    def initialize(file)
      @file = file
    end

    def to_jpeg
      raise NotImplementedError
    end

    def to_jpg
      raise NotImplementedError
    end

    def to_png
      raise NotImplementedError
    end
  end
end
