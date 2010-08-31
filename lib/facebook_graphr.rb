module FacebookGraphr
  BASE_URL = "https://graph.facebook.com/"
 
  class << self
    attr_writer :config
    def config
      if defined?(@config)
        @config
      else
        raise "Tried to access FacebookGraphr.config without calling FacebookGraphr.setup"
      end
    end
    def setup(yml_file)
      hash = File.open(yml_file) do |f|
        YAML::load(f)
      end
      self.config = if defined?(Rails)
        hash[::Rails.env].symbolize_keys
      else
        hash.symbolize_keys
      end
    end
  end

  class Session
    attr_accessor :api_key, :app_id, :user_id, :access_token, :secret_key

    def self.new_from_cookie(cookie)
      ::Rails.logger.info(cookie.inspect)
      # Sometimes cookie comes in with extra quotes in front and back
      cookie = cookie.chomp('"').reverse.chomp('"').reverse
      cookie_hash = cookie.split("&").inject({}) do |hash, pair|
        k, v = pair.split('=')
        hash.merge(k.to_sym => v)
      end
      self.new(cookie_hash[:uid], cookie_hash[:access_token])
    end

    def initialize(facebook_uid, access_token)
      self.user_id = facebook_uid
      self.access_token = access_token
      self.api_key = FacebookGraphr.config[:api_key]
      self.app_id = FacebookGraphr.config[:app_id]
      self.secret_key = FacebookGraphr.config[:secret_key]
    end

    def api(path, params = {}, method = :get)
      params = params.reverse_merge(:access_token => self.access_token)
      code, body = if method == :get
        param_string = params.map {|k, v| "#{k}=#{v}"}.join("&")
        api_get(URI.escape(BASE_URL + path + "?" + param_string))
      else
        api_post(URI.escape(BASE_URL + path), options)
      end
      if code == 200
        JSON.parse(body)
      end
    end

    #Set these up to be pluggable/overridable (e.g. so you can override them in app engine)
    def api_get(uri)
      res = HTTParty.get(uri)
      [res.code, res.body]
    end

    def api_post(uri, options)
      res = HTTParty.post(uri, options)
      [res.code, res.body]
    end
  end
end
