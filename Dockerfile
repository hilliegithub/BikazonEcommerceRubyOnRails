FROM ruby:3.2.2-alphine3.18

RUN apk add --update \
    build-base \
    mariadb-dev \
    sqlite-dev \
    nodejs \
    tzdata \
    && rm -rf /var/cache/apk/*

RUN gem install bundler

WORKDIR /app

COPY . /app/

COPY Gemfile* .

RUN bundle install

EXPOSE 3000

CMD ["rm","-f", "tmp/pids/server.pid", "&","rails", "s", "-b", "0.0.0.0"]