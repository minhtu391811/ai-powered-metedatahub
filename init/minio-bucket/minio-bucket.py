import os
from minio import Minio

client = Minio(
    "localhost:9000",
    access_key="minioadmin",
    secret_key="minioadmin",
    secure=False
)

BUCKET_NAME = "gravitino-demo"

for i in range(1, 6):
    filename = f"tmp_files/file_{i}.txt"
    
    if not os.path.exists(filename):
        with open(filename, "w") as f:
            f.write(f"Hello world! This is file {i}\n")
        print(f"Created {filename}")
        try:
            client.fput_object(BUCKET_NAME, filename, filename)
            print(f"Uploaded {filename} to bucket {BUCKET_NAME}")
        except Exception as e:
            print(f"Error uploading {filename}: {e}")
    else:
        print(f"{filename} already exists, skipping creation.")

