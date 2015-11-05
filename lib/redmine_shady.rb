module RedmineShady
  def self.intercept_mails
    ActionMailer::Base.register_interceptor(MailInterceptor)
  end

  def self.hook
    require_dependency "#{self.name.underscore}/hook"
  end

  def self.install
    hook
    intercept_mails
  end
end
