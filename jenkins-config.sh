app_tag=`git ls-remote https://github.com/javahometech/node-app HEAD | awk '{print $1}'`

docker_app="rampallidocker/nodeapp:$app_tag"
docker build -t $docker_app .

docker login -u rampallidocker -p Sriniwaas1234@ 

docker push $docker_app

scp -i /var/lib/jenkins/ELB_MUM.pem deploy.sh ubuntu@172.31.43.90:/tmp

ssh -i /var/lib/jenkins/ELB_MUM.pem ubuntu@13.232.148.95 chmod +x /tmp/deploy.sh

ssh -i /var/lib/jenkins/ELB_MUM.pem ubuntu@13.232.148.95 /tmp/deploy.sh $docker_app
