FROM ruby:2.3-alpine
MAINTAINER Andy Lim <alim@nspartners.com>

ENV BUILD_PACKAGES curl-dev ruby-dev build-base

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --update\
    bash \
    $BUILD_PACKAGES \
    libxml2-dev \
    libxslt-dev && \
    gem install nokogiri -- --use-system-libraries && \
    rm -rf /var/cache/apk/*

# Install current version of Rails
RUN gem install --no-ri --no-rdoc rails -v 4.2.5.1 && \
    mkdir -p /usr/src/app

# Copy the app into the working directory
ONBUILD WORKDIR /usr/src/app
ONBUILD COPY . /usr/src/app
ONBUILD EXPOSE 3000
ONBUILD RUN bundle install && \
            bundle clean

CMD ["rails", "server", "-b", "0.0.0.0"]
