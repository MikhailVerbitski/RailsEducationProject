# Dockerfile
FROM ruby:2.7.5

# Install runtime dependencies
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client npm

# Copy the app's code into the container
ENV APP_HOME /app
COPY . $APP_HOME
WORKDIR $APP_HOME

# Budnle gems
RUN bundle install --jobs 4

# Install Yarn packages
RUN npm install --global yarn
RUN yarn install
RUN yarn upgrade

# Expose port 3000 from the container
EXPOSE 3000

# Run puma server
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]