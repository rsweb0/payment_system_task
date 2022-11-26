FROM ruby:3.0.1-alpine

ENV BUILD_PACKAGES bash curl-dev build-base postgresql-dev yarn tzdata dcron
# Update and install all of the required packages.
# At the end, remove the apk cache
RUN apk update && \
    apk upgrade && \
    apk add --no-cache $BUILD_PACKAGES

RUN mkdir /usr/app

WORKDIR /usr/app

COPY Gemfile Gemfile.lock /usr/app/

RUN gem install bundler -v 2.2.15

RUN bundle install

COPY package.json yarn.lock /usr/app/

RUN yarn install --check-files

COPY . /usr/app

RUN crond && bundle exec whenever --set 'environment=development' --update-crontab

ENTRYPOINT ["./entrypoints/docker-entrypoint.sh"]
