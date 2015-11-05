module RedmineShady
  class MailInterceptor
    def self.delivering_email(message)
      message.perform_deliveries = false if User.current.pref[:shady]
    end
  end
end
