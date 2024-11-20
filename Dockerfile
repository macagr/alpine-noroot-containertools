FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y

RUN apt install -y python3 python3-netifaces python3-prettytable python3-certifi \
python3-chardet python3-future python3-idna python3-netaddr python3-pyparsing python3-six busybox\
 nmap curl tcpdump dnsutils jq ncat openssh-server python3-pip libcap2-bin vim golang-go pipx && \
rm -rf /var/cache/apk/*

#Kubernetes 1.8 for old clusters
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.8.4/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl18

#Kubernetes 1.12 for medium old clusters
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.12.8/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl112

#Kubernetes 1.16 for newer medium old clusters
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.16.7/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl116

#Kubernetes 1.17 for newer medium old clusters
RUN curl -LO https://dl.k8s.io/release/v1.17.17/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl117

#Kubernetes 1.18 for newer medium old clusters
RUN curl -LO https://dl.k8s.io/release/v1.18.20/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl118

#Kubernetes 1.19 for newer medium old clusters
RUN curl -LO https://dl.k8s.io/release/v1.19.11/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl119

#Kubernetes 1.20 for newer clusters
RUN curl -LO https://dl.k8s.io/release/v1.20.7/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl120

#Kubernetes 1.21.2 for newest clusters
RUN curl -LO https://dl.k8s.io/release/v1.21.2/bin/linux/amd64/kubectl && \
chmod +x kubectl && mv kubectl /usr/local/bin/kubectl

#Get docker we're not using the apk as it includes the server binaries that we don't need
RUN curl -OL https://download.docker.com/linux/static/stable/x86_64/docker-18.09.6.tgz && tar -xzvf docker-18.09.6.tgz && \
cp docker/docker /usr/local/bin && chmod +x /usr/local/bin/docker && rm -rf docker/ && rm -f docker-18.09.6.tgz

#Get etcdctl
RUN curl -OL https://github.com/etcd-io/etcd/releases/download/v3.3.13/etcd-v3.3.13-linux-amd64.tar.gz && \
tar -xzvf etcd-v3.3.13-linux-amd64.tar.gz && cp etcd-v3.3.13-linux-amd64/etcdctl /usr/local/bin && \
chmod +x /usr/local/bin/etcdctl && rm -rf etcd-v3.3.13-linux-amd64 && rm -f etcd-v3.3.13-linux-amd64.tar.gz

#Get Boltbrowser
RUN curl -OL https://bullercodeworks.com/downloads/boltbrowser/boltbrowser.linux64 && \
mv boltbrowser.linux64 /usr/local/bin/boltbrowser && chmod +x /usr/local/bin/boltbrowser

#Get AmIcontained
RUN curl -OL https://github.com/genuinetools/amicontained/releases/download/v0.4.9/amicontained-linux-amd64 && \
mv amicontained-linux-amd64 /usr/local/bin/amicontained && chmod +x /usr/local/bin/amicontained

#Get Reg
RUN curl -OL https://github.com/genuinetools/reg/releases/download/v0.16.1/reg-linux-amd64 && \
mv reg-linux-amd64 /usr/local/bin/reg && chmod +x /usr/local/bin/reg

#Get Rakkess
RUN wget https://github.com/corneliusweig/rakkess/releases/download/v0.4.4/rakkess-amd64-linux.tar.gz && \
 tar -xzvf rakkess-amd64-linux.tar.gz && chmod +x rakkess-amd64-linux && mv rakkess-amd64-linux /usr/local/bin/rakkess

#Get kubectl-who-can
RUN curl -OL https://github.com/aquasecurity/kubectl-who-can/releases/download/v0.1.0/kubectl-who-can_linux_x86_64.tar.gz && \
tar -xzvf kubectl-who-can_linux_x86_64.tar.gz && cp kubectl-who-can /usr/local/bin && rm -f kubectl-who-can_linux_x86_64.tar.gz

#Get Kube-Hunter (removed for now as it was breaking the build)
RUN pipx install kube-hunter

#Get Helm2
RUN curl -OL https://get.helm.sh/helm-v2.16.12-linux-amd64.tar.gz && \
tar -xzvf helm-v2.16.12-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm2 && \
chmod +x /usr/local/bin/helm2 && rm -rf linux-amd64 && rm -f helm-v2.16.12-linux-amd64.tar.gz

#Get Helm3
RUN curl -OL https://get.helm.sh/helm-v3.1.1-linux-amd64.tar.gz && \
tar -xzvf helm-v3.1.1-linux-amd64.tar.gz && mv linux-amd64/helm /usr/local/bin/helm3 && \
chmod +x /usr/local/bin/helm3 && rm -rf linux-amd64 && rm -f helm-v3.1.1-linux-amd64.tar.gz

#Get Go-Pillage-Registries
RUN curl -OL https://github.com/nccgroup/go-pillage-registries/releases/download/v1.0/go-pillage-registries_1.0_Linux_x86_64.tar.gz && \
tar -xzvf go-pillage-registries_1.0_Linux_x86_64.tar.gz && mv go-pillage-registries /usr/local/bin && \
rm -f go-pillage-registries_1.0_Linux_x86_64.tar.gz

# Install kdigger
RUN curl -OL https://github.com/quarkslab/kdigger/releases/download/v1.4.0/kdigger-linux-amd64 && \
mv kdigger-linux-amd64 /usr/local/bin/kdigger && chmod +x /usr/local/bin/kdigger

#Get oc 3.10
RUN curl -OL https://github.com/openshift/origin/releases/download/v3.10.0/openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz && \
tar -xzvf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz && cp openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit/oc /usr/local/bin/oc310 && \
chmod +x /usr/local/bin/oc310 && rm -rf openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit && rm -f openshift-origin-client-tools-v3.10.0-dd10d17-linux-64bit.tar.gz

#Get oc 3.11
RUN curl -OL https://github.com/openshift/origin/releases/download/v3.11.0/openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && \
tar -xzvf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && cp openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit/oc  /usr/local/bin && \
chmod +x /usr/local/bin/oc && rm -f openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit.tar.gz && rm -rf openshift-origin-client-tools-v3.11.0-0cbc58b-linux-64bit

#install coredns enum
RUN wget https://github.com/jpts/coredns-enum/releases/download/v0.2.4/coredns-enum_v0.2.4_linux_amd64.tar.gz && \
tar -xzvf coredns-enum_v0.2.4_linux_amd64.tar.gz && cp coredns-enum /usr/local/bin && \
chmod +x /usr/local/bin/coredns-enum && rm coredns-enum && rm coredns-enum_v0.2.4_linux_amd64.tar.gz

# Conmachi
COPY /bin/conmachi /usr/local/bin/

#Set Capabilities on busybox
RUN setcap 'cap_net_raw,cap_net_bind_service,cap_chown,cap_dac_override,cap_fowner,cap_fsetid,cap_kill,cap_setgid,cap_setuid,cap_setpcap,cap_sys_chroot,cap_mknod,cap_audit_write,cap_setfcap=+ep' /bin/busybox


#Having a setuid shell could be handy
RUN cp /bin/bash /bin/setuidbash && chmod 4755 /bin/setuidbash
# Adding extra capabilities to python may be nice too :)
#RUN setcap 'cap_chown+ep' /bin/python3
RUN echo 'root:123' | chpasswd

#Create a group for our user
RUN addgroup --gid 1001 --system tester

#create our new user
RUN adduser --system --ingroup tester --uid 1001 tester

#set the workdir, why not
WORKDIR /home/tester



#Put a Sample Privileged Pod Chart in the Image
RUN mkdir charts
COPY --chown=tester /charts/* /home/tester/charts/


RUN mkdir manifests
COPY --chown=tester /manifests/* /home/tester/manifests/

USER tester

# This is a Dumb Hack
CMD ["tail", "-f" , "/dev/null"]


