class NotificationJob < ApplicationJob
  queue_as :default

  def perform(notification_id)
    notification = Notification.find(notification_id)
    begin
      NotificationMailer.send_notification(notification).deliver_now
      notification.update(status: :sent)
    rescue StandardError => e
      Rails.logger.error("Failed to send notification: #{e.message}")
      notification.update(status: :failed)
    end
  end
end