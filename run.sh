docker build --tag danielubuntu .
docker run -d -P -i -t danielubuntu
docker exec $(docker ps | grep -vwE "(CONTAINER ID|ubuntu)" | awk '{print $1}') service ssh restart
docker ps
