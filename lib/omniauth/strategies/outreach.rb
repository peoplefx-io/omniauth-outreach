require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Outreach < OmniAuth::Strategies::OAuth2
      option :name, 'outreach'
      option :client_options, site: 'https://api.outreach.io'

      uid do
        raw_info['meta']['user']['email']
      end

      info do
        {
          email: raw_info['meta']['user']['email'],
          api: raw_info['meta']['api']
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        puts "access_token: #{access_token.inspect}"
        @raw_info ||= access_token.get('/oauth/token').parsed
        puts "raw_info: #{raw_info}"
        @raw_info
      end

      # Work-around for https://github.com/intridea/omniauth-oauth2/issues/93.
      def callback_url
        response = options[:redirect_uri] || (full_host + script_name + callback_path)
        puts "response: #{response}"
        response
      end
    end
  end
end
