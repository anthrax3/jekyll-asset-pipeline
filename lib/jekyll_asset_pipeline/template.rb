module JekyllAssetPipeline
  # Base class for the tag templates
  # See https://github.com/matthodan/jekyll-asset-pipeline#templates
  class Template
    include JekyllAssetPipeline::TemplateHelper
    extend JekyllAssetPipeline::SubclassTracking

    def initialize(path, filename)
      @path = path
      @filename = filename
    end

    # Filetype to process (e.g. '.js')
    def self.filetype
      ''
    end

    # Priority of template (to override default templates)
    def self.priority
      0
    end

    # Finds a template class based on a filename
    def self.klass(filename)
      klasses = JekyllAssetPipeline::Template.subclasses.select do |t|
        t.filetype == File.extname(filename).downcase
      end
      klasses.sort! { |x, y| x.priority <=> y.priority }.last
    end

    # HTML output to return
    #
    # Available instance variables:
    # @filename       Name of bundle file
    # @path           Path to bundle file
    #
    # Returns string
    def html
      "#{@path}/#{@filename}\n"
    end
  end
end