# https://github.com/sjiveson/nfs-server-alpine
docker build --platform=linux/amd64 --tag j2lab/nfs-server:1.0 .
docker push j2lab/nfs-server:1.0

# docker run -d --name nfs --privileged -v /Users/eric/works/j2lab-fw-k8s/imports/nfs-server/data:/nfsshare -e SHARED_DIRECTORY=/nfsshare j2lab/nfs-server:1.0