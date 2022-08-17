FROM ubuntu:latest

RUN apt update
RUN apt install ruby-full -y
RUN apt install build-essential zlib1g-dev -y
ENV GEM_HOME="$HOME/gems"
ENV PATH="$HOME/gems/bin:$PATH"
RUN gem install jekyll bundler
RUN mkdir /data/
WORKDIR /data/
COPY . ./
RUN bundle install
ENTRYPOINT bundle exec jekyll serve
