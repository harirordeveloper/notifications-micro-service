class ServiceWorker
  include Sidekiq::Worker

  def perform(service_name, message)
    case service_name
    when "admin"
      # process admin message
    when "company"
      # process company message
    when "notification"
      # process notification message
    end
  end
end