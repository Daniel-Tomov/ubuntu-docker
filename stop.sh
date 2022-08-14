sudo docker stop $(docker ps | grep -vwE "(CONTAINER ID|ubuntu)" | awk '{print $1}')
sudo docker container prune -f
