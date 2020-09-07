Flutter Docker

docker build --tag flutter_docker:latest .
docker tag flutter_docker docker.pkg.github.com/sebastianklaiber/flutter_docker/flutter_docker:<flutter-version>
docker push docker.pkg.github.com/sebastianklaiber/flutter_docker/flutter_docker:<flutter-version>