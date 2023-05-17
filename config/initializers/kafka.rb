require "#{Rails.root}/app/services/kafka_service"
Thread.new do
  KafkaService.consume("employee")
  KafkaService.consume("admin_employee")
end
