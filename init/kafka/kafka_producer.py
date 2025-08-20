from kafka import KafkaProducer, KafkaAdminClient
from faker import Faker
import json
import random
import time
import traceback

BOOTSTRAP_SERVERS = "localhost:19092"
TOPIC_NAME = "gravitino"

fake = Faker()

def wait_for_topic(topic_name, timeout=60):
    start = time.time()
    print(f"[DEBUG] Checking Kafka connection to {BOOTSTRAP_SERVERS}")
    while time.time() - start < timeout:
        try:
            admin = KafkaAdminClient(bootstrap_servers=BOOTSTRAP_SERVERS)
            topics = admin.list_topics()
            print(f"[DEBUG] Found topics: {topics}")
            admin.close()
            if topic_name in topics:
                print(f"[INFO] Topic '{topic_name}' đã sẵn sàng.")
                return True
            else:
                print(f"[WARN] Topic '{topic_name}' chưa tồn tại. Còn {timeout - (time.time() - start):.1f}s")
        except Exception as e:
            print(f"[ERROR] Kafka chưa sẵn sàng ({type(e).__name__}): {e}")
            traceback.print_exc()
        time.sleep(2)
    raise TimeoutError(f"Topic '{topic_name}' chưa sẵn sàng sau {timeout} giây.")

def generate_fake_data():
    return {
        "id": random.randint(1, 100000),
        "name": fake.name(),
        "email": fake.email(),
        "address": fake.address(),
        "created_at": fake.iso8601()
    }

if __name__ == "__main__":
    try:
        wait_for_topic(TOPIC_NAME)
    except TimeoutError as e:
        print(f"[FATAL] {e}")
        exit(1)

    print(f"[DEBUG] Connecting KafkaProducer to {BOOTSTRAP_SERVERS}")
    try:
        producer = KafkaProducer(
            bootstrap_servers=BOOTSTRAP_SERVERS,
            value_serializer=lambda v: json.dumps(v).encode("utf-8")
        )
    except Exception as e:
        print(f"[FATAL] Không tạo được KafkaProducer: {e}")
        traceback.print_exc()
        exit(1)

    print(f"[INFO] Bắt đầu gửi dữ liệu vào Kafka topic: {TOPIC_NAME}")
    try:
        for i in range(10):
            data = generate_fake_data()
            future = producer.send(TOPIC_NAME, value=data)
            result = future.get(timeout=10)
            print(f"[DEBUG] Sent message {i+1}: {data} | Metadata: {result}")
        producer.flush()
    except Exception as e:
        print(f"[ERROR] Lỗi khi gửi dữ liệu: {e}")
        traceback.print_exc()
    finally:
        producer.close()
        print("[INFO] Hoàn tất gửi dữ liệu.")
