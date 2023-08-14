FROM ruby:3.2.2-slim-bullseye

# Common dependencies
RUN echo 'Binary::apt::APT::Keep-Downloaded-Packages "true";' > /etc/apt/apt.conf.d/keep-cache; \
  apt-get update -qq \
  && apt-get install -yq --no-install-recommends \
    build-essential \
    gnupg2 \
    curl \
    less \
    git \
    vim

# Install Libsodium dependency
RUN apt-get update -qq && apt-get -yq dist-upgrade && \
  apt-get install -yq --no-install-recommends \
    libsodium-dev


RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
  apt-get update -qq && apt-get -yq dist-upgrade && \
  apt-get install -yq --no-install-recommends nodejs
RUN npm install -g yarn@1.22.17

# Configure bundler
ENV LANG=C.UTF-8 \
  BUNDLE_JOBS=4 \
  BUNDLE_RETRY=3

# Store Bundler settings in the project's root
ENV BUNDLE_APP_CONFIG=.bundle

# Create a directory for the app code
ENV APP_DIR=/app

RUN mkdir -p /app
WORKDIR $APP_DIR

# Upgrade RubyGems and install the latest Bundler version
RUN gem update --system && \
    gem install bundler -v 2.4.18


# Adding some aliases
RUN echo 'alias stop_warnings="export RUBYOPT="-W0""' >> ~/.bashrc
RUN echo 'alias bi="bundle install"' >> ~/.bashrc
RUN echo 'alias bsdev="bin/app/start_bot_dev"' >> ~/.bashrc

# Document that we're going to expose port 3000
EXPOSE 3000
# Use Bash as the default command
CMD ["bash"]