docker build --platform=linux/amd64 -t j2lab/spark-py:v3.3.0 -f sparkpy.dockerfile ./
docker push j2lab/spark-py:v3.3.0
