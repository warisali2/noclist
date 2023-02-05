# frozen_string_literal: true

require_relative 'utils/load_gems'
require_relative 'app/client'

begin

  host = ENV['BADSEC_HOST']
  raise 'ENV["BADSEC_HOST"] not set' if host.nil?

  c = Client.new(host)

  users = c.users
  puts users.to_json

rescue StandardError => e
  warn e.message
  exit 1
end
