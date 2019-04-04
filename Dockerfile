FROM ruby:2.6

RUN echo "Building from Dockerfile"

RUN mkdir -p /app
ADD . /app
WORKDIR /app

RUN gem install bundler
RUN bundle install --retry 5