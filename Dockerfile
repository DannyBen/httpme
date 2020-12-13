FROM dannyben/alpine-ruby:ruby2.6.5
RUN gem install httpme --version 0.1.4
WORKDIR /docroot
EXPOSE 3000
ENTRYPOINT ["httpme"]