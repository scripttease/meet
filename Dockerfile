# Start with the base ruby image
From ruby:2.3.0-alpine

# Install C dependencies for postgres client gem
RUN apk update && apk add build-base postgresql-dev

ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME

# Increase security by running app as non-root user
ENV USER meet-app
RUN adduser -D -u 1000 $USER && chown $USER  --recursive .
USER $USER

# Install ruby app dependencies
COPY Gemfile* $APP_HOME/
RUN gem install bundler && bundle install

# Add application source
COPY . $APP_HOME

# Start server
ENV PORT 4000
EXPOSE 4000
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "4000"]
