
### Build and run docker container
```console
docker build -t ba-jenkins .
sudo docker run -v jenkins-home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -p 8081:8080 --name jenkins -d kadirzade/ba-jenkins 
sudo docker exec -it jenkins mkdir -p /root/.kube 
sudo docker cp ~/.kube/config jenkins:/root/.kube/config 
sudo docker cp ~/.bringaway/dev/jenkins_home/parameters.groovy jenkins:/var/jenkins_home/parameters.groovy
```