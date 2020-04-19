FROM centos:latest
WORKDIR /tmp/
RUN curl -o helm.tgz https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz && \
    tar -zxvf helm.tgz

FROM centos:latest
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN yum -y update && \
    yum install -y kubectl git
COPY --from=0 /tmp/linux-amd64/helm /usr/local/bin/helm
