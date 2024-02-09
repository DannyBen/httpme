FROM dannyben/alpine-ruby:3.1.3

RUN gem install httpme --version 0.2.2

WORKDIR /docroot

VOLUME /docroot

EXPOSE 3000

ENTRYPOINT ["httpme"]
