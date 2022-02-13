FROM cirrusci/flutter:2.10.1

RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa wget libsqlite3-dev libssl-dev lcov zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev g++ gcc autoconf automake bison libc6-dev libffi-dev libgdbm-dev libncurses5-dev libtool libyaml-dev make pkg-config zlib1g-dev libgmp-dev libreadline-dev libssl-dev android-sdk ruby ruby-dev
RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg
RUN gem install fastlane -NV 

