require 'omniauth-oauth2'

module OmniAuth
  module Strategies
    class Outreach < OmniAuth::Strategies::OAuth2
      option :name, 'outreach'
      option :client_options, {
				parse: :json,
				site: 'https://api.outreach.io'
			}

      uid do
        raw_info['meta']['user']['email']
      end

			credentials do
				{
					access_token: access_token.token,
					expires_at: access_token.expires_at,
					expires_in: access_token.expires_in,
					refresh_token: access_token.refresh_token,
					scope: access_token.params["scope"],
					created_at: access_token.params["created_at"],
					token_type: access_token.params["token_type"]
				}
			end

      info do
        {
          email: raw_info['meta']['user']['email'],
					first_name: raw_info['meta']['user']['firstName'],
					last_name: raw_info['meta']['user']['lastName'],
        }
      end

      extra do
        {
          'raw_info' => raw_info
        }
      end

      def raw_info
        @raw_info ||= access_token.get('/api/v2').parsed
      end

      # Work-around for https://github.com/intridea/omniauth-oauth2/issues/93.
      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end
    end
  end
end
