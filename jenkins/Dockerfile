FROM jenkins/jenkins:lts
ENV JENKINS_USER admin
ENV JENKINS_PASS admin
USER root

# Skip initial setup
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# install docker
RUN apt-get update && apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common

# RUN curl -fsSL https://download.docker.com/linux/$(. /etc/os-release; echo "$ID")/gpg | apt-key add -
# RUN add-apt-repository \
#     "deb [arch=amd64] https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") \
#     $(lsb_release -cs) \
#     stable"
# RUN apt-get update && apt-get install -y docker-ce
# RUN usermod -aG docker jenkins

# install jq
# RUN apt-get update && apt-get install jq

# install kubectl
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl; chmod +x ./kubectl; mv ./kubectl /usr/local/bin/kubectl

# install helm
RUN curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3; chmod 700 get_helm.sh; ./get_helm.sh

# install docker compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose; chmod +x /usr/local/bin/docker-compose

# install glooctl
RUN curl -L -sL https://run.solo.io/gloo/install | sh ; export PATH=$HOME/.gloo/bin:$PATH


RUN curl -o aws-iam-authenticator https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator; chmod +x ./aws-iam-authenticator; mv ./aws-iam-authenticator /usr/local/bin/aws-iam-authenticator

# Setting the number of executors
COPY executors.groovy /usr/share/jenkins/ref/init.groovy.d/executors.groovy

# Install default plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

RUN mkdir -p /root/.kube
RUN mkdir -p /root/.aws

ENTRYPOINT ["/usr/local/bin/jenkins.sh"]