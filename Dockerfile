FROM cimg/android:2023.12.1-node

USER circleci

RUN sudo apt update
RUN sudo apt install -y sqlite3 libsqlite3-dev

WORKDIR /home/circleci

# Install brew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

RUN brew install dart-sdk

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