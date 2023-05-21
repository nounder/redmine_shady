module RedmineShady
  def self.intercept_mails
    ActionMailer::Base.register_interceptor(MailInterceptor)
  end

  def self.hook
    require File.expand_path("../#{self.name.underscore}/hook", __FILE__)
  end

  def self.install
    hook
    intercept_mails
  end
end
