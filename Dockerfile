# Container image that runs your code
FROM ruby:2.6-alpine

# Install necessary gems
RUN gem install aws-sdk-secretsmanager
RUN gem install fastball --source https://Gfgyva8mFUA6fPCfz6uV@gem.fury.io/me/ -v 0.5.0

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY main.rb /main.rb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
