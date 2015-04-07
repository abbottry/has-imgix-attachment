module Imgix
  class Attachment
    attr_reader :name, :instance, :options, :styles

    def initialize(name, instance, options = {})
      @name     = name
      @instance = instance
      @options  = options
    end

    # generate the full imgix url for the provided style
    def url(style = nil)
      # construct the pieces of the url
      full_url = [@instance.base_url, @options[:prefix], filename].compact.join("/")

      # append imgix params to the filename before returning
      styled_filename(full_url, style)
    end

    def self.url(filename, style)
      # url including source previx
      full_url = [@instance.base_url, @options[:prefix], filename].compact.join("/")

      # add the style options and return
      styled_filename(full_url, style)
    end

    # Determine the field/column name to find the filename in
    def filename_field
      @options.fetch(:filename_field, "filename")
    end

    # Determine the field/column name to find the content_type in
    def content_type_field
      @options.fetch(:content_type_field, "content_type")
    end

    # Determine the field/column name to find the file size in
    def file_size_field
      @options.fetch(:file_size_field, "file_size")
    end

    # Retrieve the filename from the instance provided
    def filename
      # attempt to get the value from the database, but fall back
      # to a default image supplied
      @instance.send(self.filename_field) || @options[:default]
    end

    # Retrieve the content type from the instance provided
    def content_type
      @instance.send(self.content_type_field)
    end

    # Retrieve the file_size from the instance provided
    def file_size
      @instance.send(self.file_size_field)
    end

    # Append query parameters to the filename of this attachment
    def styled_filename(url, style)
      if style.present? && self.styles.include?(style.to_sym)
        return [url, self.style(style).to_s].join("?")
      end

      # default to the basic url, without any options
      return url
    end

    # Retrieve a particular style of this attachment
    def style(style = nil)
      # look for the provided style, return an empty has by default
      self.styles.fetch(style.to_sym, {})
    end

    # Retrieve all styles provided for this attachment
    def styles
      # initialize an empty hash
      styles = {}

      @options.fetch(:styles, {}).each_pair do |name, options|
        styles[name.to_sym] = Imgix::Style.new(name, self, options)
      end

      # returns the hash of Imgix::Style objects
      styles
    end
  end
end