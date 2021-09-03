#  k3s kubectl cheat sheet for PiFarm

From:  https://kubernetes.io/docs/reference/kubectl/cheatsheet/


##  Show all Nodes

$ kubectl get nodes
```
NAME       STATUS   ROLES                  AGE   VERSION
pi-serv1   Ready    control-plane,master   19h   v1.21.4+k3s1
pi-108     Ready    <none>                 19h   v1.21.4+k3s1
pi-113     Ready    <none>                 19h   v1.21.4+k3s1
pi-101     Ready    <none>                 19h   v1.21.4+k3s1
pi-100     Ready    <none>                 19h   v1.21.4+k3s1
pi-102     Ready    <none>                 19h   v1.21.4+k3s1
pi-103     Ready    <none>                 19h   v1.21.4+k3s1
```
## Get list of contexts

$ kubectl config get-contexts
```
CURRENT   NAME      CLUSTER   AUTHINFO   NAMESPACE
*         default   default   default    
```


## Show Merged kubeconfig settings.

$ kubectl config view 
```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: DATA+OMITTED
    server: https://192.168.2.110:6443
  name: default
contexts:
- context:
    cluster: default
    user: default
  name: default
current-context: default
kind: Config
preferences: {}
users:
- name: default
  user:
    client-certificate-data: REDACTED
    client-key-data: REDACTED
```

## List all services in the namespace
$ kubectl get services
```
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   19h
```

## List all pods in all namespaces
$ kubectl get pods --all-namespaces
```
NAMESPACE     NAME                                      READY   STATUS      RESTARTS   AGE
kube-system   local-path-provisioner-5ff76fc89d-5lgt8   1/1     Running     0          19h
kube-system   metrics-server-86cbb8457f-bd66x           1/1     Running     0          19h
kube-system   helm-install-traefik-crd-w9pmt            0/1     Completed   0          19h
kube-system   helm-install-traefik-65xsv                0/1     Completed   1          19h
kube-system   svclb-traefik-9fmtk                       2/2     Running     0          19h
kube-system   coredns-7448499f4d-n497j                  1/1     Running     0          19h
kube-system   traefik-97b44b794-4mz7p                   1/1     Running     0          19h
kube-system   svclb-traefik-8d7t7                       2/2     Running     0          19h
kube-system   svclb-traefik-z4mqs                       2/2     Running     0          19h
kube-system   svclb-traefik-mb46g                       2/2     Running     0          19h
kube-system   svclb-traefik-xq9bs                       2/2     Running     0          19h
kube-system   svclb-traefik-djk24                       2/2     Running     0          19h
kube-system   svclb-traefik-scrwf                       2/2     Running     0          19h
```
== Get nodes in wide

$ kubectl get node -o wide
```
NAME       STATUS   ROLES                  AGE   VERSION        INTERNAL-IP     EXTERNAL-IP   OS-IMAGE                       KERNEL-VERSION   CONTAINER-RUNTIME
pi-serv1   Ready    control-plane,master   22h   v1.21.4+k3s1   192.168.2.110   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-108     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.108   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-100     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.100   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-101     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.101   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-113     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.113   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-103     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.103   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
pi-102     Ready    <none>                 21h   v1.21.4+k3s1   192.168.2.102   <none>        Debian GNU/Linux 10 (buster)   5.10.60-v8+      containerd://1.4.9-k3s1
```
                   
