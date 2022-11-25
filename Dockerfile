FROM dannyben/alpine-ruby:3.0.3
RUN gem install httpme --version 0.2.0
WORKDIR /docroot
EXPOSE 3000
ENTRYPOINT ["httpme"]