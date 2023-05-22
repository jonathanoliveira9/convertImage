require 'securerandom'

module ConvertImage
  class Convert < Base
    def to_jpeg
      f = read
      write(f, 'jpeg')
    end

    def to_png
      f = read
      write(f, 'png')
    end

    def to_jpg
      f = read
      write(f, 'jpg')
    end

    def write(resource, format)
      new_name = "#{name}.#{format}"
      resource.write(new_name)
      new_file = File.open(new_name)
      tempfile = Tempfile.new([new_name, ".#{format}"])
      tempfile.write(new_file.read)
      #File.delete(new_file)
      tempfile.rewind
      tempfile.binmode
    end

    def read
      ImageList.new(file)
    end

    def name
      file
      "#{File.basename(file, '.*')}-#{SecureRandom.urlsafe_base64}"
    end
  end
end
