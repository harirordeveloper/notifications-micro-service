class NotificationServiceWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(message)
    message = eval(message)
    Rails.logger.info "Received notification trigger from Service :: #{message[:service_id]}, with message :: #{message}"
    # case service_name
    # when "admin_management_api"
    #   Rails.logger.info "Received notification trigger from Service :: #{service_name}, with message :: #{message}"
    # when "company_management_api"
    #   Rails.logger.info "Received notification trigger from Service :: #{service_name}, with message :: #{message}"
    # end
  end
end