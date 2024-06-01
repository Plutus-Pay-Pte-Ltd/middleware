class NotificationMailer < ApplicationMailer
  def send_notification(notification)
    @notification = notification
    mail(to: @notification.recipient_email, subject: @notification.subject)
  end
end
