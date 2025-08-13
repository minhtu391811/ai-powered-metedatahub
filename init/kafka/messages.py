from kafka import KafkaProducer
from faker import Faker
import json
import random

fake = Faker()

producer = KafkaProducer(
    bootstrap_servers="localhost:19092",
    value_serializer=lambda v: json.dumps(v).encode("utf-8")
)

TOPIC_NAME = "gravitino"

def generate_fake_data():
    return {
        "id": random.randint(1, 100000),
        "name": fake.name(),
        "email": fake.email(),
        "address": fake.address(),
        "created_at": fake.iso8601()
    }

if __name__ == "__main__":
    print(f"Bắt đầu gửi dữ liệu vào Kafka topic: {TOPIC_NAME}")
    try:
        for _ in range(10):
            data = generate_fake_data()
            producer.send(TOPIC_NAME, value=data)
            print(f"Sent: {data}")

        producer.flush()

    except Exception as e:
        print(f"Lỗi khi gửi dữ liệu: {e}")
    finally:
        producer.close()
        print("Hoàn tất gửi dữ liệu.")