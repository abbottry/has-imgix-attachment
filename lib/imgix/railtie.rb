module Imgix
  class Railtie < ::Rails::Railtie
    initializer 'imgix.model_additions' do
      ActiveSupport.on_load(:active_record) do
        include Imgix::ModelExtensions
      end

      ActiveSupport.on_load(:action_view) do
        include Imgix::ActionView::Helpers
      end
    end
  end
end
