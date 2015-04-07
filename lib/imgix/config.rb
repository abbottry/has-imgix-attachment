module Imgix
    class Config
        DEFAULT_IMGIX_ATTACHMENT_ATTR = :photo
        DEFAULT_IMGIX_PROTOCOL = "https"
        DEFAULT_IMGIX_BASE_URL = "imgix.net"

        attr_reader :base_url, :subdomain, :protocol

        def field_name(name = nil)
            if name.nil?
                @field_name || Imgix::Config::DEFAULT_IMGIX_ATTACHMENT_ATTR
            else
                @field_name = name
            end
        end

        def base_url(url = nil)
            if url.nil?
                @base_url || Imgix::Config::DEFAULT_IMGIX_BASE_URL
            else
                @base_url = url
            end
        end

        def subdomain(_subdomain = nil)
            if _subdomain.nil?
                @subdomain || Imgix::Config::DEFAULT_IMGIX_PROTOCOL
            else
                @subdomain = _subdomain
            end
        end

        def protocol(_protocol = nil)
            if _protocol.nil?
                @protocol || Imgix::Config::DEFAULT_IMGIX_PROTOCOL
            else
                @protocol = _protocol
            end
        end
    end
end