FROM cimg/android:2024.11.1-node

USER circleci

RUN sudo apt update
RUN sudo apt install -y sqlite3 libsqlite3-dev
RUN sudo apt-get update

WORKDIR /home/circleci

RUN sudo apt-get update && sudo apt-get install apt-transport-https
RUN wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo gpg  --dearmor -o /usr/share/keyrings/dart.gpg
RUN echo 'deb [signed-by=/usr/share/keyrings/dart.gpg arch=amd64] https://storage.googleapis.com/download.dartlang.org/linux/debian stable main' | sudo tee /etc/apt/sources.list.d/dart_stable.list
RUN sudo apt-get update && sudo apt-get install dart

# Print version
RUN dart --version

# Install fvm
RUN dart pub global activate fvm

# Install melos dart package
RUN dart pub global activate melos

# Install junitreporer dart package for test results
RUN dart pub global activate junitreport

ENV PATH="/home/circleci/.pub-cache/bin:$PATH"
ENV PATH="$HOME/fvm/default/bin:$PATH"

RUN echo "flutter=fvm flutter" >> ~/.bashrc

# Install fastlane
RUN sudo gem install fastlane -NV