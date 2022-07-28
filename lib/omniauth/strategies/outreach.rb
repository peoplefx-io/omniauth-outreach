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
					refresh_token: access_tokne.refresh_token,
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
         puts "access_token: #{access_token.inspect}"
        # @raw_info ||= access_token.get('/oauth/token').parsed
        @raw_info ||= access_token.get('/api/v2').parsed
				#, headers: {
				#	'Authorization' => "Bearer #{access_token.token}",
				#	'Content-Type' => "application/vnd.api+json",
				#})

        #puts "raw_info: #{@raw_info}"
				#puts "status: #{@raw_info.status}"
				#puts "headers: #{@raw_info.headers}"
				#puts "body: #{@raw_info.body}"


				#@raw_info = @raw_info.parsed
        #puts "raw_info.parsed: #{@raw_info}"

        @raw_info
      end

      # Work-around for https://github.com/intridea/omniauth-oauth2/issues/93.
      def callback_url
        options[:redirect_uri] || (full_host + script_name + callback_path)
      end

    end
  end
end
