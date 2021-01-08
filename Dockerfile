FROM ubuntu:18.04

################################################################################################
###
### Prerequisites
###  
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget libsqlite3-dev libssl-dev lcov zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev g++ gcc autoconf automake bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libtool libyaml-dev make pkg-config zlib1g-dev libgmp-dev libreadline-dev libssl-dev
   
################################################################################################
###
### Set up new user
### 
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

################################################################################################
###
### Prepare Android directories and system variables
###
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg


################################################################################################
###
### Install Ruby & bundler
###
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv \
  &&  echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc \
  &&  echo 'eval "$(rbenv init -)"' >> ~/.bashrc

ENV HOME /home/developer 
ENV PATH "$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH"
ENV RUBY_VERSION 2.6.3

RUN mkdir -p "$(rbenv root)"/plugins \
    && git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build

RUN rbenv install $RUBY_VERSION

RUN rbenv global $RUBY_VERSION && rbenv versions && ruby -v

################################################################################################
###
### Install Fastlane and plugins
###
RUN gem install fastlane -NV 
   
################################################################################################
###
### Set up Android SDK
###
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

################################################################################################
###
### Download Flutter SDK
###
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin"
RUN flutter channel stable

RUN flutter upgrade
   
################################################################################################
###
### Run basic check to download Dark SDK
###
RUN flutter doctor