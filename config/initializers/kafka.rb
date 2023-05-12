require "#{Rails.root}/app/services/kafka_service"

KafkaService.consume("employee")
