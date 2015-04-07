module Imgix
  class Style
    attr_reader :name, :options

    VALID_PARAMS = [:auto, :bg, :blend, :blendalign, :blendalpha,
      :blendcrop, :blendfit, :blendheight, :blendmode, :blendpadding,
      :blendsize, :blendwidth, :blur, :border, :bri, :colors, :con,
      :crop, :dl, :dpr, :exp, :fit, :flip, :fm, :gam, :h, :high, :htn,
      :hue, :invert, :mark, :markalign, :markfit, :markh, :markpad,
      :markscale, :markw, :mask, :mono, :nr, :nrs, :or, :page, :palette,
      :prefix, :px, :q, :rect, :rot, :sat, :sepia, :shad, :sharp, :txt,
      :txtalign, :txtclip, :txtclr, :txtfit, :txtfont, :txtline, :txtlineclr,
      :txtpad, :txtshad, :txtsize, :txtwidth, :vib, :w]

    def initialize(name, attachment, options = {})
      @name       = name
      @attachment = attachment
      @options    = options
      if @options.is_a?(Hash)
        @options = @options.delete_if {|k, v| !Imgix::Style.is_param_valid?(k) }
      end
    end

    def to_s
      self.options.to_param
    end

    def self.is_param_valid?(param)
      VALID_PARAMS.include?(param.to_sym)
    end
  end
end