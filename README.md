# HTTPMe

[![Gem Version](https://badge.fury.io/rb/httpme.svg)](https://badge.fury.io/rb/httpme)
[![Build Status](https://github.com/DannyBen/httpme/workflows/Test/badge.svg)](https://github.com/DannyBen/victor/actions?query=workflow%3ATest)

---

Static files web server with basic authentication.

---

## Installation

    $ gem install httpme

## Usage


```shell
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

