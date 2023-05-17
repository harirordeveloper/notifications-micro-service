class NotificationMailer < ApplicationMailer
  default from: 'harirordeveloper@gmail.com'

  def send_notification(user_email, notification_text, data={})
    @notification_text = notification_text
    @data = data
    mail(to: user_email, subject: 'Notification')
  end
end
