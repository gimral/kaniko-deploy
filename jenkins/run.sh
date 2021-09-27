docker rm -f jenkins
docker build -t gimral/custom-jenkins:1.0 .
# docker run -v jenkins-home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock -p 8081:8080 --name jenkins -d ba-jenkins 
# docker exec -it jenkins mkdir -p /root/.kube 
# docker cp ~/.kube/config jenkins:/root/.kube/config 
# docker cp ~/Desktop/parameters.groovy jenkins:/var/jenkins_home/parameters.groovy