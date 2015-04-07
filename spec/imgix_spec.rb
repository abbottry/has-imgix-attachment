require 'spec_helper'

describe Imgix do
  it 'has a version number' do
    expect(Imgix::VERSION).not_to be nil
  end
end

describe Imgix::Config do
  it "generates the correct field name" do
    expect(Entity.imgix_config.field_name).to eq(:photo)
  end

  it "generates the correct protocol name" do
    expect(Entity.imgix_config.protocol).to eq('https')
  end

  it "generates the correct subdomain" do
    expect(Entity.imgix_config.subdomain).to eq('imgix-subdomain')
  end

  it "generates the correct base url" do
    expect(Entity.imgix_config.base_url).to eq('imgix.net')
  end
end

describe Imgix::ModelExtensions do
  it "responds to has_imgix_attachment" do
    expect(Entity).to respond_to(:has_imgix_attachment)
  end
end

describe Imgix::Attachment do
  before(:all) do
    @entity = Entity.create(filename: "test.jpg", file_size: 12943, content_type: "image/jpg")
  end

  it "is retrieved directly by name" do
    expect(@entity).to respond_to(:photo)
  end

  it "responds to url" do
    expect(@entity.imgix_attachment).to respond_to(:url)
    expect(@entity.imgix_attachment).to respond_to(:url).with(1).argument
  end

  it "returns the default when expected" do
    @entity = Entity.create()

    expect(@entity.imgix_attachment.filename).to eq("default.png")
  end

  it "gathers the correct styles" do
    expect(@entity.imgix_attachment.style(:thumb).options).to eq({
       :h    => 90,
       :w    => 110,
       :fit  => "crop"
    })
    expect(@entity.imgix_attachment.style(:large).options).to eq({
       :h    => 480,
       :w    => 640,
       :fit  => "crop"
    })
  end

  it "generates the correct url" do
    expect(@entity.imgix_attachment.url()).to eq('https://imgix-subdomain.imgix.net/photos/test.jpg')
  end

  it "generates the correct query arguments" do
    query_args = Rack::Utils.parse_query(URI.parse(@entity.imgix_attachment.url(:thumb)).query)
    expect(query_args).to eq({
       "h"    => "90",
       "w"    => "110",
       "fit"  => "crop"
    })
  end

  it "comprehends default column names" do
    expect(@entity.imgix_attachment.filename).to eq("test.jpg")
    expect(@entity.imgix_attachment.file_size).to eq(12943)
    expect(@entity.imgix_attachment.content_type).to eq("image/jpg")
  end

  it "comprehends custom column names" do
    @custom_entity = CustomFieldsEntity.create(picture_name: "c_test.jpg", picture_size: 22943, picture_type: "image/jpeg")

    expect(@custom_entity.imgix_attachment.filename).to eq("c_test.jpg")
    expect(@custom_entity.imgix_attachment.file_size).to eq(22943)
    expect(@custom_entity.imgix_attachment.content_type).to eq("image/jpeg")
  end
end

describe Imgix::Style do
  before(:all) do
    @entity = Entity.create(filename: "test.jpg", file_size: 12943, content_type: "image/jpg")
  end

  it "only accepts valid params" do
    expect(Imgix::Style.is_param_valid?(:h)).to eq(true)
    expect(Imgix::Style.is_param_valid?(:w)).to eq(true)

    expect(Imgix::Style.is_param_valid?(:random)).to eq(false)
  end
end