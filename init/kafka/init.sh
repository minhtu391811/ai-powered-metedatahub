set -e

echo "Chờ Kafka broker sẵn sàng..."
until kafka-topics.sh --bootstrap-server kafka:9092 --list >/dev/null 2>&1; do
  sleep 2
done

TOPICS=("gravitino" "system" "user")

for topic in "${TOPICS[@]}"; do
    echo "Tạo topic: $topic"
    kafka-topics.sh --create --if-not-exists \
        --bootstrap-server kafka:9092 \
        --replication-factor 1 \
        --partitions 1 \
        --topic "$topic"
done

echo "Hoàn tất tạo topic"