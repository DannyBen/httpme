FROM dannyben/alpine-ruby:3.3.3

RUN gem install httpme --version 0.2.4

WORKDIR /docroot

VOLUME /docroot

EXPOSE 3000

ENTRYPOINT ["httpme"]
