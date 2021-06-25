require 'aws-sdk-secretsmanager'
require 'json'
require 'yaml'

# *******************
# *******************
puts "Starting Secrets Fastball script"

aws_access_key_id     = ENV['INPUT_AWS_ACCESS_KEY_ID']
aws_secret_access_key = ENV['INPUT_AWS_SECRET_ACCESS_KEY']
aws_region            = ENV['INPUT_AWS_REGION']

secret_keys_string    = ENV['INPUT_SECRET_KEYS']
secret_keys           = YAML.load(secret_keys_string)

# *******************
# *******************
puts "Getting Secrets from AWS"

credentials = Aws::Credentials.new(aws_access_key_id, aws_secret_access_key)
sm = Aws::SecretsManager::Client.new(region: aws_region, credentials: credentials)

output = {}

secret_keys.each do |secret_key|
  secret = JSON.parse sm.get_secret_value(secret_id: secret_key).secret_string
  output = output.merge(secret)
end

# downcase the keys or fastball gets angry
output = output.transform_keys(&:downcase)

File.open('app_config.json', 'w') do |f|
  f.puts output.to_json
end

# *******************
# *******************
puts "Running $ fastball config"
system("fastball config")
