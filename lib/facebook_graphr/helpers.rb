module FacebookGraphr
  module Helpers
    module Init
      def init_facebook_graph_js(opts = {})
        js_lib = (opts[:js] || :jquery).to_sym
        if js_lib != :jquery
          raise "Currently unsupported JS library: #{js_lib}"
        end
        <<-EOS
    <script src="http://connect.facebook.net/en_US/all.js"></script>
    <div id="fb-root"></div>
      <script type="text/javascript">
//<![CDATA[
        jQuery(document).ready( function() {
           FB.init({appId: '#{FacebookGraphr.config[:app_id]}', status: true, cookie: true, xfbml: true});
           FB.Event.subscribe('auth.sessionChange', function(response) {
             window.location.reload();
           });
        });
//]]>
      </script>

        EOS
      end
    end
    module FBML
      # can have size => :thumb, :small, :normal, and :square
      # :linked => true/false
      def facebook_profile_pic(fbuid, options = {})
        options = options.dup
        content_tag("fb:profile-pic", nil, options.merge(:uid => fbuid))
      end
    end
  end
end
