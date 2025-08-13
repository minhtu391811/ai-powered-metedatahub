set -e

echo "Chờ Kafka sẵn sàng..."

sleep 5

TOPICS=("test-topic" "orders" "users")

for topic in "${TOPICS[@]}"; do
    echo "Tạo topic: $topic"
    kafka-topics.sh --create --if-not-exists \
        --bootstrap-server kafka:9092 \
        --replication-factor 1 \
        --partitions 1 \
        --topic "$topic"
done

echo "Hoàn tất tạo topic"