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

        // stage('docker build') {  
        //     steps {              
        //         script {
        //             sh("kubectl apply -f deploy/deploy.yaml")  
        //             sh("/usr/local/bin/wait-on-kaniko-job.sh")      
        //         } 
        //     }                                             
        // }

        stage('tag') {
            steps{
                sh("git tag -a ${IMAGE_TAG} -m 'Jenkins'")
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: '7d28effb-6679-40bd-a7f2-90b4d6da1ced', usernameVariable: 'GIT_USERNAME', passwordVariable: 'GIT_PASSWORD']]) {
                        sh("${git} config credential.username ${env.GIT_USERNAME}")
                        sh("${git} config credential.helper '!f() { echo password=\$GIT_PASSWORD; }; f'")
                        sh("GIT_ASKPASS=true ${git} push origin --tags")    

                        sh("${git} config --unset credential.username")
                        sh("${git} config --unset credential.helper")
                    }
            }
        }

                              
    }
}
                                   
