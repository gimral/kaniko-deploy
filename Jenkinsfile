pipeline {   
    
    // environment {
    //     PARAMETERS_FILE = "${JENKINS_HOME}/parameters.groovy"  
    //     CONTAINER_REGISTRY_SECRET_NAME="dockerhub"
    //     API_PARAMETERS_FILE_NEW="deployment/k8s/helm/${JOB_NAME}-api/parameters.groovy"  
    // }     

    parameters {
        string (name: 'IMAGE_TAG', defaultValue: 'latest',  description: 'Image tag to deploy. Image tag will be updated if deployment environment is dev. It is applicable only for production')       
    }    

    agent any
    
    stages {
        stage('preparation') {
            steps {                
                checkout scm
                script {
                    IMAGE_TAG = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
                }
                //sh "kubectl cluster-info" 

                // script {
                //     if (! fileExists("${PARAMETERS_FILE}")) {
                //         echo "ERROR: ${PARAMETERS_FILE} is missing!"
                //     }
                // }

                // load "${PARAMETERS_FILE}"

                // echo "DOCKER_REG is ${DOCKER_REG}"  
                // echo "DOCKER_REPO is ${DOCKER_REPO}"
                
                // script {
                //     if (! fileExists("${API_PARAMETERS_FILE_NEW}")) {
                //         echo "ERROR: ${API_PARAMETERS_FILE_NEW} is missing!"
                //     }
                // }

                // load "${API_PARAMETERS_FILE_NEW}"
            }
        }     

        stage('docker build') {  
            steps {              
                script {
                    sh("kubectl apply -f deploy/deploy.yaml")  
                    sh("/usr/local/bin/wait-on-kaniko-job.sh")      
                } 
            }                                             
        }

        stage('tag') {
            steps{
                sh("git tag -a ${IMAGE_TAG} -m 'Jenkins'")
                sh("git push origin --tags")
            }
        }

                              
    }
}
                                   
