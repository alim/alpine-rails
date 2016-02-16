FROM ruby:2.3-alpine
MAINTAINER Andy Lim <alim@nspartners.com>

ENV BUILD_PACKAGES="curl-dev ruby-dev build-base bash" \
    DEV_PACKAGES="zlib-dev libxml2-dev libxslt-dev tzdata yaml-dev sqlite-dev postgresql-dev mysql-dev" \
    RUBY_PACKAGES="ruby-json yaml nodejs"

# Update and install base packages and nokogiri gem that requires a
# native compilation
RUN apk update && \
    apk upgrade && \
    apk add --update\
    $BUILD_PACKAGES \
    $DEV_PACKAGES \
    $RUBY_PACKAGES && \
    rm -rf /var/cache/apk/* && \
    mkdir -p /usr/src/app

# Copy the app into the working directory. This assumes your Gemfile
# is in the root directory and includes your version of Rails that you
# want to run.
ONBUILD WORKDIR /usr/src/app
ONBUILD COPY . /usr/src/app
ONBUILD EXPOSE 3000
ONBUILD RUN bundle config build.nokogiri --use-system-libraries && \
            bundle install && \
            bundle clean

CMD ["rails", "server", "-b", "0.0.0.0"]
