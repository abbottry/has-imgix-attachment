module Imgix
  module ActionView
    module Helpers
      # Simple image_tag override that uses imgix as the source
      def imgix_tag(object, style, html_options = {})
        image_tag(imgix_url(object, style), html_options)
      end

      # Helper that will return only a url
      def imgix_url(object, style)
        if object && object.respond_to?('url')
          object.url(style)
        else
          Attachment.url(object, style)
        end
      end
    end
  end
end