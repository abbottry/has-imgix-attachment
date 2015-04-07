# has-imgix-attachment

has-imgix-attachment allows you to easier work with the [imgix](http://www.imgix.com/) API through model defined attributes for easier retrieval.

## Installation

Add this line to your application's Gemfile:

    gem 'has-imgix-attachment'

And then execute:

    $ bundle

## Model Configuration

To add imgix to your model, you simply need to call the `has-imgix-attachment` method on your model.

```ruby
class Post < ActiveRecord::Base
  has_imgix_attachment :photo,
    :subdomain => "imgix-subdomain",
    :default   => "default.png",
    :prefix    => "photos",
    :styles =>  {
      :thumbnail  => {
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
```

The `has-imgix-attachment` method will take accept a name, and a list of options. The first value is the name and of the field that we'll create (which can also be referenced with `imgix_attachment`). Below is a list of valid options that can follow the name.

### Options

* `subdomain` - Subdomain defined within your imgix account
* `default` - Name of the image to be used as a default image (must appear in the bucket with all other images)
* `prefix` - If your bucket has folders, supply the folder name here
* `filename_field` - Override the default column name for the image filename. Default: **filename**
* `file_size_field` - Override the default column name for the image file size. Default: **file_size**
* `content_type_field` - Override the default column name for the image content type. Default: **content_type**
* `styles` - Hash that defines all the variations of the image you'd like to be able to refer to

**NOTE:** Examples of the model configurations can be found in the [`spec/support/models.rb`](spec/support/models.rb) file.

## Usage

The gem comes with a view helper ``imgix_tag`` which is just an extension of the ``image_tag``.

```ruby
<%= imgix_tag(@post.photo, "large") %>
```
will generate the same thing as, just a less verbose shortcut
```ruby
<%= imgix_tag(@post.imgix_attachment, "large") %>
```

imgix_tag will accept all the same additional options that image_tag supports

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
    * Please make sure to include the appropriate specs
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

See [LICENSE.txt](LICENSE.txt).