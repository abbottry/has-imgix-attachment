module Imgix
  module InstanceMethods
    # def attachment_for(name, options)
    #   @_attachments ||= {}
    #   @_attachments[name] ||= Imgix::Attachment.new(name, self, options)
    # end

    # Detrmine the base url given the imgix configurations
    def base_url
        url = URI::Generic.build(
            scheme: self.class.imgix_config.protocol(),
            host: [self.class.imgix_config.subdomain(), self.class.imgix_config.base_url()].join(".")
        )

        return url
    end
  end
end