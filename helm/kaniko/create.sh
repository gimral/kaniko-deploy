kubectl create -f maven-pv.yaml
kubectl create -f maven-pvc.yaml
kubectl create -f kaniko-cache-pv.yaml
kubectl create -f kaniko-cache-pvc.yaml 