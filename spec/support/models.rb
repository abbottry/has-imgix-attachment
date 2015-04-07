require 'active_record'

load File.dirname(__FILE__) + '/schema.rb'

class Entity < ActiveRecord::Base
  has_imgix_attachment :photo,
    :subdomain  => "imgix-subdomain",
    :default    => "default.png",
    :prefix     => "photos",
    :styles =>  {
      :thumb  => {
        :h    => 90,
        :w    => 110,
        :fit  => "crop"
      },
      :large  => {
        :h    => 480,
        :w    => 640,
        :fit  => "crop"
      }
    }
end

class CustomFieldsEntity < ActiveRecord::Base
  has_imgix_attachment :photo,
    :subdomain          => "imgix-subdomain",
    :default            => "default.png",
    :prefix             => "photos",
    :filename_field     => "picture_name",
    :file_size_field    => "picture_size",
    :content_type_field => "picture_type",
    :styles =>  {
      :thumb  => {
        :h    => 90,
        :w    => 110,
        :fit  => "crop"
      },
      :large  => {
        :h    => 480,
        :w    => 640,
        :fit  => "crop"
      }
    }
end