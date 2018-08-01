FROM ruby:2.5.1
MAINTAINER rajahafiy.zaed@gmail.com

# Make sure that we install nodejs 8.0
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -

# Since Yarn uses https for their package, we make sure that
# we support https packages here first before installation.
RUN apt-get update && apt-get install -y apt-transport-https

# Setup Yarn and make sure that yarn uses /cache/yarn as its
# cache.
ENV YARN_CACHE_FOLDER /cache/yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update && apt-get install -y \
  postgresql-client \
  build-essential \
  locales \
  nodejs \
  vim \
  yarn

# Use vim as the default editor.
ENV EDITOR vi

# Make /app our working directory.
RUN mkdir -p /app
WORKDIR /app

# Copy the main application.
COPY . ./

# Install bundler and make sure that the gems are cached
# at /cache/bundle.
ENV BUNDLE_PATH /cache/bundle
RUN gem install bundler
RUN bundle install

# Configure an entry point, so we don't need to specify
# "bundle exec" for each of our commands.
ENTRYPOINT ["./bin/docker/run"]
