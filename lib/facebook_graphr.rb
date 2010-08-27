module FacebookGraphr
  BASE_URL = "https://graph.facebook.com/"
 
  class << self
    attr_accessor :config
    def self.setup(yml_file)
      hash = File.open(yml_file) do |f|
        YAML::load(f)
      end
      self.config = if defined?(Rails)
        hash[Rails.env].symbolize_keys
      else
        hash.symbolize_keys
      end
    end
  end

  class Session
    attr_accessor :api_key, :app_id, :user_id, :access_token, :secret_key

    def self.new_from_cookie(cookie)
      Rails.logger.info(cookie.inspect)
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
      res = if method == :get
        param_string = params.map {|k, v| "#{k}=#{v}"}.join("&")
        HTTParty.get(URI.escape(BASE_URL + path + "?" + param_string))
      else
        HTTParty.post(URI.escape(BASE_URL + path), options)
      end
      if res.code == 200
        JSON.parse(res.body)
      end
    end
  end
end
