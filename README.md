[![Build](https://circleci.com/gh/scripttease/meet.svg?style=shield)](https://circleci.com/gh/scripttease/meet)
[![Code Climate](https://codeclimate.com/github/scripttease/meet/badges/gpa.svg)](https://codeclimate.com/github/scripttease/meet)
[![Test Coverage](https://codeclimate.com/github/scripttease/meet/badges/coverage.svg)](https://codeclimate.com/github/scripttease/meet/coverage)

```
  ███╗   ███╗███████╗███████╗████████╗██╗
  ████╗ ████║██╔════╝██╔════╝╚══██╔══╝██║
  ██╔████╔██║█████╗  █████╗     ██║   ██║
  ██║╚██╔╝██║██╔══╝  ██╔══╝     ██║   ╚═╝
  ██║ ╚═╝ ██║███████╗███████╗   ██║   ██╗
  ╚═╝     ╚═╝╚══════╝╚══════╝   ╚═╝   ╚═╝
```

# Usage

First install Docker and Docker Compose.

```sh
make                  # Print help
docker-compose build  # Build the docker images
docker-compose up     # Run the app in docker
make test             # Run the tests
make lint             # Run the linter
make repl             # Start the interactive shell
```
