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
To work on infrastructure you must also install Terraform.

```sh
make                  # Print help
docker-compose build  # Build the docker images
docker-compose up     # Run the app in docker
make test             # Run the tests
make lint             # Run the linter
make repl             # Start the interactive shell
```


## Application

The application is written in Ruby with the Sinatra web framework. It is
backed by a Postgresql database. In development the app and the database run
inside Docker containers managed by `docker-compose`.


## Infrastructure

The infrastructure is managed using Terraform, which is a declaritive language
for provisioning and managing infrastructure. The Terraform code lives in the
repository so all infrastructure changes can be reviewed and repeatable across
different environments, etc.
