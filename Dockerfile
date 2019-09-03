FROM centos:latest
WORKDIR /tmp/
RUN curl -o helm.tgz https://get.helm.sh/helm-v2.14.3-linux-amd64.tar.gz && \
    tar -zxvf helm.tgz

FROM centos:latest
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN yum -y update && \
    yum install -y kubectl git wget && \
    mkdir -p /root/.helm/plugins
COPY --from=0 /tmp/linux-amd64/helm /usr/local/bin/helm
RUN helm plugin install https://github.com/chartmuseum/helm-push
