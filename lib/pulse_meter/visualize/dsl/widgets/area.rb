module PulseMeter
  module Visualize
    module DSL
      module Widgets
        class Area < PulseMeter::Visualize::DSL::Widget
          self.data_class = PulseMeter::Visualize::Widgets::Area

          string_setter :values_label
          bool_setter :show_last_point

          int_setter :timespan do |ts|
            raise BadWidgetTimeSpan, ts unless ts > 0
          end

        end
      end
    end
  end
end

