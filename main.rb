require 'aws-sdk-secretsmanager'
require 'json'

# appears to be running from repo folder.

# set variables
aws_access_key_id 	  = ENV['INPUT_AWS_ACCESS_KEY_ID']
aws_secret_access_key = ENV['INPUT_AWS_SECRET_ACCESS_KEY']
aws_region 			  = ENV['INPUT_AWS_REGION']
secret_keys 		  = ENV['INPUT_SECRET_KEYS']

puts aws_access_key_id
puts aws_secret_access_key
puts aws_region
puts secret_keys          

credentials = Aws::Credentials.new(aws_access_key_id, aws_secret_access_key)
sm = Aws::SecretsManager::Client.new(region: aws_region, credentials: credentials)

output = {}

secret_keys.each do |secret_key|
	secret = JSON.parse sm.get_secret_value(secret_id: secret_key).secret_string
	output = output.merge(secret)
end

File.open('app_config.json', 'w') do |f|
	f.puts output
end

puts output
