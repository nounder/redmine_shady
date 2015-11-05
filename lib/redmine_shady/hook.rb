module RedmineShady
  module Hook
    class ViewListener < Redmine::Hook::ViewListener
      # necessary for using content_tag in Listener
      attr_accessor :output_buffer

      # If shady, show message on the top
      def view_layouts_base_html_head(context = {})
        session = context[:controller].session

        if User.current.pref[:shady]
          style = 'margin: 0; padding: 10px; border-width: 0 0 2px; background-image: none'

          content_tag :div, id: 'shady-bar', class: 'flash error', style: style do
            concat link_to l(:button_cancel), { controller: 'shady', action: 'destroy' },
                           method: :delete, style: 'float: right'
            concat l(:notice_shady_mode)
          end
        end
      end
    end
  end
end
