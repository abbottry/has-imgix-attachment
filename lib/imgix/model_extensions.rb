require 'active_support/concern'

module Imgix
  module ModelExtensions
    extend ActiveSupport::Concern

    module ClassMethods
      def imgix_config
        @imgix_config ||= Imgix::Config.new
      end

      def has_imgix_attachment(name, options = {})
        include InstanceMethods

        imgix_config.base_url(options.delete(:base_url))
        imgix_config.protocol(options.delete(:protocol))
        imgix_config.subdomain(options.delete(:subdomain))

        define_method(name) do |*args|
          a = Imgix::Attachment.new(name, self, options)
        end

        # simple helper method to use instead of having to use
        # the name provided
        define_method("imgix_attachment") do ||
          self.send(name)
        end

        # Define how the setter of our attachment works
        # define_method "#{name}=" do |file|
        #   attachment_for(name).assign(file)
        # end

        # Determine if the attachment is valid
        # define_method "#{name}?" do
        #   attachment_for(name).file?
        # end
      end
    end
  end
end