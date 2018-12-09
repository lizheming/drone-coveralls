![logo](coveralls.svg)

# drone-coveralls


[![BuildStatus](https://cat.eming.li/api/badges/lizheming/drone-coveralls/status.svg)](https://cat.eming.li/lizheming/drone-coveralls)
[![Coverage Status](https://coveralls.io/repos/github/lizheming/drone-coveralls/badge.svg?branch=master)](https://coveralls.io/github/lizheming/drone-coveralls?branch=master)
[![Docker Pulls](https://img.shields.io/docker/pulls/lizheming/drone-coveralls.svg)]()
[![](https://images.microbadger.com/badges/image/lizheming/drone-coveralls.svg)](https://microbadger.com/images/lizheming/drone-coveralls)

Drone plugin for pushing test coverage to coveralls

This plugin allows for pushing test coverage results to [Coveralls.io](https://coveralls.io).

## Configuration
First of all you should set environment `COVERALLS_REPO_TOKEN` for plugin. And the following parameters are used to configure the plugin:

files: list of target files to upload. Required.
token: if you have not set environment `COVERALLS_REPO_TOKEN`, you should set the private repository token.
debug: debug mode, defaults to false.

### Drone configuration examples

```yaml
steps:
- name: test
  image: node:alpine
  commands:
  - npm install
  - npm run test -- --reporter=text-lcov > ./lcov.info

- name: coveralls
  image: lizheming/drone-coveralls
  environment:
    COVERALLS_REPO_TOKEN:
      from_secret: coveralls_token
  settings:
    files:
    - ./lcov.info
```