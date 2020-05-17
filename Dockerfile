FROM centos:latest
WORKDIR /tmp/
RUN curl -Lo helm.tgz https://get.helm.sh/helm-v3.1.2-linux-amd64.tar.gz && \
    tar -zxvf helm.tgz

FROM centos:latest
WORKDIR /tmp/
RUN curl -Lo kustomize.tgz https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2Fv3.5.5/kustomize_v3.5.5_linux_amd64.tar.gz && \
    tar -zxvf kustomize.tgz

FROM centos:latest
WORKDIR /tmp/
RUN curl -Lo helm2.tgz https://get.helm.sh/helm-v2.16.7-linux-amd64.tar.gz && \
    tar -zxvf helm2.tgz

FROM centos:latest
COPY kubernetes.repo /etc/yum.repos.d/kubernetes.repo
RUN yum -y update && \
    yum install -y kubectl git
COPY --from=0 /tmp/linux-amd64/helm /usr/local/bin/helm
COPY --from=1 /tmp/kustomize /usr/local/bin/kustomize
COPY --from=2 /tmp/linux-amd64/helm /usr/local/bin/helm2
