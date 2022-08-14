docker container prune -f
sudo docker rmi $(docker images | grep -vwE "(REPOSITORY|ubuntu)" | awk '{print $3}')
