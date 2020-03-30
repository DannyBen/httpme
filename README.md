# httpme - static web server with basic authentication

[![Gem Version](https://badge.fury.io/rb/httpme.svg)](https://badge.fury.io/rb/httpme)
[![Build Status](https://github.com/DannyBen/httpme/workflows/Test/badge.svg)](https://github.com/DannyBen/victor/actions?query=workflow%3ATest)
[![Maintainability](https://api.codeclimate.com/v1/badges/6626f32d6a99288dcc98/maintainability)](https://codeclimate.com/github/DannyBen/httpme/maintainability)

---

httpme is a command line utility for serving static HTMLs and other files
with optional basic authentication support.

---

## Installation

    $ gem install httpme

## Docker

Start the web server and mount the current directory:

```shell
$ docker run --rm -it -p 3000:3000 -v $PWD:/docroot dannyben/httpme
```

Or, with basic authentication

```shell
$ export HTTPME_AUTH=user:password
$ docker run --rm -it -p 3000:3000 -v $PWD:/docroot \
    -e HTTPME_AUTH dannyben/httpme
```

Or, with docker-compose:

```yaml
version: '3'

services:
  web:
    build: .
    image: dannyben/httpme
    volumes: [".:/docroot"]
    ports: ["3000:3000"]
    environment:
      HTTPME_AUTH:
```

## Usage


```
$ httpme --help

httpme - static web server with basic authentication

Options can be set using command line arguments or environment variables

Usage:
  httpme [PATH] [--port PORT --host HOST --auth AUTH]
  httpme (-h|--help)

Options:
  -p, --port PORT
    Server port (default: 3000)

  -o, --host HOST
    Server host (default: 0.0.0.0)

  -a, --auth AUTH
    Specify user:password to enable basic authentication

  -h --help
    Show this help

Parameters:
  PATH
    Path to the directory you want to serve [default: .]

Environment Variables:
  HTTPME_PATH
    Same as --path

  HTTPME_AUTH
    Same as --auth

  HTTPME_PORT
    Same as --port

  HTTPME_HOST
    Same as --host

Examples:
  httpme -p 3000
  httpme docs --auth admin:s3cr3t
  HTTPME_AUTH=admin:s3cr3t httpme docs  # same result as above
```

