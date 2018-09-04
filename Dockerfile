FROM ruby:2.5.1

RUN apt-get update -qq && apt-get -y install \
	vim \
	build-essential \
	libpq-dev \
	nodejs \
	mysql-client

RUN mkdir /myapp

COPY Gemfile /myapp
COPY Gemfile.lock /myapp

WORKDIR /myapp
RUN gem install bundler && bundle install --without production

ENV COLUMNS=200 LINES=50
