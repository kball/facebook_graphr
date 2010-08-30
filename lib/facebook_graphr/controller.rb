module FacebookGraphr
  module Rails
    module Controller
      def self.included(controller)
        controller.helper_method :facebook_graph_session
      end

      def facebook_graph_session
        @facebook_graph_session ||= begin
          cookie = cookies["fbs_#{FacebookGraphr.config[:app_id]}"]
          FacebookGraphr::Session.new_from_cookie(cookie) if cookie
        end
      end
    end
  end
end
