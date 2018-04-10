require 'fastlane/action'

module Fastlane
  module Actions
    class NappNotificationsAction < Action
      def self.run(params)
        require 'base64'
        
        # set the base url
        base_url = "https://notifications.napp.dk"
        if params[:base_url]
          base_url = params[:base_url]
        end

        cert_p12 = params[:cert_p12]
        cert_password = params[:cert_password]
        app_id = params[:app_id]
        admin_key = params[:admin_api_key]
        bundle_id = params[:bundle_id]

        connection = self.connection(base_url)

        if !File.exist?(cert_p12)
          UI.error("Certificate not found 🚫")
          abort
        end

        # setting the payload
        payload = {}
        payload[:apns_bundle_id] = bundle_id

        # pass the certificate
        data = File.read(params[:cert_p12])
        cert_p12 = Base64.encode64(data)
        payload["certificate"] = cert_p12
        payload["certificate_password"] = cert_password
        payload["apns_bundle_id"] = bundle_id

        response = connection.post do |req|
          req.url("api/v1/apps/" + app_id + "/platform/ios")
          req.headers['X-NAPP-PUSH-ADMIN-KEY'] = admin_key
          req.headers['X-NAPP-PUSH-APP-ID'] = app_id
          req.body = payload
        end

        case response.status
        when 200...300
          UI.message("✅ Successfully uploaded new Push Notification iOS certificate ✅")
        else
          UI.error("🚫 Error trying to create iOS platform: #{response.status} - #{response.body}")
        end

      end

      def self.connection(base_url)
        require 'faraday'
        require 'faraday_middleware'

        foptions = {
          url: base_url
        }
        Faraday.new(foptions) do |builder|
          #builder.request :multipart
          builder.request :url_encoded
          builder.response :json, content_type: /\bjson$/
          builder.use FaradayMiddleware::FollowRedirects
          builder.adapter :net_http
        end
      end

      def self.description
        "Napp Notifications"
      end

      def self.authors
        ["Mads Møller"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Napp Notifications"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :admin_api_key,
                                       env_name: "NAPP_NOTIFICATIONS_ADMIN_KEY",
                                       description: "Admin API Key",
                                       optional: false,
                                       type: String),
          FastlaneCore::ConfigItem.new(key: :app_id,
                                        env_name: "NAPP_NOTIFICATIONS_APP_ID",
                                        optional: false,
                                        description: "App id",
                                        type: String),
          FastlaneCore::ConfigItem.new(key: :cert_p12,
                                        env_name: "NAPP_NOTIFICATIONS_P12_CERT_PATH",
                                        optional: false,
                                        description: "File path of the certificate .p12",
                                        type: String),
          FastlaneCore::ConfigItem.new(key: :cert_password,
                                        env_name: "NAPP_NOTIFICATIONS_P12_CERT_PASSWORD",
                                        optional: false,
                                        description: ".p12 File path of the certificate",
                                        type: String),
          FastlaneCore::ConfigItem.new(key: :bundle_id,
                                        env_name: "NAPP_NOTIFICATIONS_BUNDLE_ID",
                                        optional: false,
                                        description: "Bundle id of the app",
                                        type: String),
          FastlaneCore::ConfigItem.new(key: :base_url,
                                       env_name: "NAPP_NOTIFICATIONS_BASE_URL",
                                       optional: true,
                                       type: String,
                                       description: "Private cloud option")
        ]
      end

      def self.is_supported?(platform)
        [:ios].include?(platform)
      end

      def self.example_code
        [
          'napp_notifications(
            admin_api_key: "Napp Notifications API-KEY",
            app_id: "Napp Notifications App Id",
            bundle_id: "com.example.helloworld",
            cert_p12: "Path to Apple .p12 file",
            cert_password: "Password for .p12 file",
            base_url: "URL to server (optional)"
          )'
        ]
      end

      def self.category
        :push
      end

    end
  end
end
