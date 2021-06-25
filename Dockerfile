# Container image that runs your code
FROM ruby:2.6-alpine

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh bin/entrypoint.sh
COPY main.rb bin/main.rb

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["bin/entrypoint.sh"]
