#!/bin/sh
set -e

# Start MinIO server in background
minio server /data --console-address ":9001" &
MINIO_PID=$!

# Wait for MinIO to be ready
echo "Waiting for MinIO server..."
until mc alias set localminio http://localhost:9000 "$MINIO_ROOT_USER" "$MINIO_ROOT_PASSWORD" 2>/dev/null; do
    echo "MinIO not ready, retrying..."
    sleep 2
done

# Create bucket if missing
if ! mc ls localminio/gravitino-demo >/dev/null 2>&1; then
    echo "Creating bucket: gravitino-demo"
    mc mb localminio/gravitino-demo
else
    echo "Bucket already exists"
fi

# Keep server running
wait $MINIO_PID