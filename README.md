Flutter Docker

docker build --tag flutter_docker:latest .
docker tag flutter_docker docker.pkg.github.com/sebastianklaiber/flutter_docker/flutter_docker:0.2.0
docker push docker.pkg.github.com/sebastianklaiber/flutter_docker/flutter_docker:0.2.0