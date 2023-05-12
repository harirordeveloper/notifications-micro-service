class KafkaService

  KAFKA_BROKERS = ENV['KAFKA_BROKERS'].split(',')
  KAFKA_CLUSTER_USERNAME = ENV['KAFKA_CLUSTER_USERNAME']
  KAFKA_CLUSTER_PASSWORD = ENV['KAFKA_CLUSTER_PASSWORD']
  KAFKA_PRODUCER = Kafka.new(
    seed_brokers: KAFKA_BROKERS,
    ssl_ca_certs_from_system: true,
    sasl_plain_username: KAFKA_CLUSTER_USERNAME,
    sasl_plain_password: KAFKA_CLUSTER_PASSWORD,
    client_id: 'notification-management',
    socket_timeout: 60 # Socket timeout in seconds
  )

  KAFKA_CONSUMER = Kafka.new(
    seed_brokers: KAFKA_BROKERS,
    ssl_ca_certs_from_system: true,
    sasl_plain_username: KAFKA_CLUSTER_USERNAME,
    sasl_plain_password: KAFKA_CLUSTER_PASSWORD,
    client_id: 'notification-management',
    logger: Rails.logger,
    socket_timeout: 60 # Socket timeout in seconds
  )

  def self.producer
    @producer ||= KAFKA_PRODUCER.producer
  end

  def self.send_message(topic, message)
    producer.produce(message, topic: topic)
    producer.deliver_messages
  end

  def self.consumer
    @consumer ||= KAFKA_CONSUMER.consumer(group_id: "notification_management_api")
  end

  def self.consume(topic)
    consumer.subscribe(topic)
    Thread.new do
      consumer.each_message do |message|
        NotificationServiceWorker.perform_async(message.value)
      end
    end
  end
end
