CLUSTER_IP=$(minikube ip)
sudo mkdir -p /etc/resolver
echo "nameserver $CLUSTER_IP" | sudo tee $@
sudo touch /etc/resolver