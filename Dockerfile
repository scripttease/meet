# Start with the base ruby image
From ruby:2.3.0-alpine

# Install ruby app dependencies
ENV APP_HOME /app
RUN mkdir $APP_HOME
WORKDIR $APP_HOME
COPY Gemfile* $APP_HOME/
RUN bundle install

# Add application source
COPY . $APP_HOME

# Start server
ENV PORT 4000
EXPOSE 4000
CMD ["bundle", "exec", "rackup", "--host", "0.0.0.0", "--port", "4000"]
