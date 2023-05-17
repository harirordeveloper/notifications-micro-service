class NotificationServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message)
    message = eval(message)
    data = message[:data].with_indifferent_access
    action = message[:action]
    email = data[:email]
    case action
    when 'create'
      NotificationMailer.send_notification(email, "You were added as an employee.", data).deliver_now
    when 'update'
      NotificationMailer.send_notification(email, "Your details got updated.", data).deliver_now
    when 'delete'
      NotificationMailer.send_notification(email, "Your account got deleted.").deliver_now
    end
    Rails.logger.info "Received notification trigger from Service :: #{message[:service_id]}, with message :: #{message}"
  end
end
