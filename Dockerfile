# From ruby:2.5
FROM ruby:2.5

# Run apt update
RUN apt-get update -qq

# Run to install nodejs
RUN apt-get install -y nodejs

# Run to install postgresql-client
RUN apt-get install -y postgresql-client

# Make /myapp directory
RUN mkdir /omruby

# Define Workon directory
WORKDIR /omruby

# Copy Gemfile and Gemfile.lock
COPY Gemfile /omruby/Gemfile
COPY Gemfile.lock /omruby/Gemfile.lock

# Bundle Install
RUN bundle install

# Copy current files to omruby
COPY . /omruby

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
