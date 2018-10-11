# frozen_string_literal: true

module ApplicationCable
  # 接続しているユーザー ≒ current_user を定義する
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private

      def find_verified_user
        session_key = cookies.encrypted[Rails.application.config.session_options[:key]]
        verified_id = session_key['warden.user.user.key'][0][0]
        verified_user = User.find_by(id: verified_id)
        return verified_user if verified_user && cookies.signed['user.expires_at'] > Time.now
        reject_unauthorized_connection
      end
  end
end
