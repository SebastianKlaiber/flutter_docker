FROM cimg/android:2024.01.1-node

USER circleci

RUN sudo apt update
RUN sudo apt install -y sqlite3 libsqlite3-dev

WORKDIR /home/circleci

# Install brew
RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"

# Install fvm
RUN brew tap leoafarias/fvm
RUN brew install fvm

# Install melos dart package
RUN dart pub global activate melos

# Install junitreporer dart package for test results
RUN dart pub global activate junitreport

ENV PATH="/home/circleci/.pub-cache/bin:$PATH"

# Install fastlane
RUN sudo gem install fastlane -NV