if Rails.env.production?
  require 'exception_notification'

  Rails.application.config.middleware.use ExceptionNotification::Rack,
    email: {
      email_prefix: '[SG] ',
      sender_address: %["exception_notifier" <noreply@slidegate.herokuapp.com>],
      exception_recipients: [ENV['MAIL_TO']]
    }

  ExceptionNotifier::Rake.configure
end
