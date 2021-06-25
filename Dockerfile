# Container image that runs your code
FROM ruby:2.6-alpine

# Install necessary gems
gem install aws-sdk-secretsmanager
gem install fastball --source https://github.com/kalkomey/fastball

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY main.rb /main.rb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
