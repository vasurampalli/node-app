node{
    def imgVersion = UUID.randomUUID().toString()
    def dockerImage = "rampallidocker/nodeapp:${imgVersion}"
    stage('Source Checkout'){
        
        git 'https://github.com/rampallidocker/node-app'
    }
    
    
    stage('Build Docker Image'){
        //sh "docker build -t ${dockerImagerampallidocker"
	  sh "sudo usermod -a -G docker $rampallidocker"
	  sh "sudo docker build -t rampallidocker/nodeapp:1.1 ."
    }
    
    stage('Push DockerHub'){
		withCredentials([string(credentialsId: 'docker-hub', variable: 'dockerhubPwd')]) {
			sh "docker login -u rampallidocker -p ${dockerhubPwd}"
		}
        
        //sh "docker push ${dockerImage}"
	  sh "docker push rampallidocker/nodeapp:1.1"
    }
    
	stage('Dev Deploy'){
		//def dockerRun = "docker run -d -p 9090:8080 --name nodeapp ${dockerImage}"
		  def dockerRun = "docker run -d -p 9090:8080 --name nodeapp rampallidocker/nodeapp:1.1"
		sshagent(['dev-docker']) {
		    try{
				sh "ssh -o StrictHostKeyChecking=no ubuntu@13.232.148.95 docker rm -f nodeapp "
			}catch(e){
			
			
			}
			sh "ssh  ubuntu@13.232.148.95 ${dockerRun}"
		}
	}
}
