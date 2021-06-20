Ubuntu Container Tools - No Root Docker Image
--

This is an image based on the alpine-noroot-containertools from Raesene. It is a
fork where I have based myself on Ubuntu to add a few more tools that I needed
to work. In particular the OpenShift Client tools.  I have also added a few
tools and all the versions of kubectl that I could.


Tools installed
--
- nmap
- curl
- etcd
- kubectl
- docker client
- boltbrowser
- oc
- amicontained
- kube-hunter


Running Instructions
--
`docker run -it macagr/ubuntu-noroot-containertools /bin/sh`
