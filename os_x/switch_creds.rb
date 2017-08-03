#!/usr/bin/env ruby

# This tool is used to rotate your access keys based on entries in an aws credentials file
# install inifile gem
#   gem install inifile
# put this in your bash_profile
#   alias switch_creds='~/r/tools/this_script.rb'
#   alias src='source ~/.bash_profile'
# Then run:
#   switch_creds the_profile_name && src

require 'inifile'

profile = ARGV[0]

profile = 'default' if profile.nil?
out_file = "#{ENV['HOME']}/.aws_creds"

creds = IniFile.load("#{ENV['HOME']}/.aws/credentials")

if creds[profile].empty?
  puts "Could not file profile: #{profile}"
  exit
end

cred_content = "export AWS_ACCESS_KEY_ID=#{creds[profile]['aws_access_key_id']}\n"
cred_content << "export AWS_SECRET_ACCESS_KEY=#{creds[profile]['aws_secret_access_key']}\n"

File.write(out_file, cred_content)

