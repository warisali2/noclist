require_relative '../utils/load_gems'

class Client
  include HTTParty
  attr_accessor :auth_token

  def initialize(host)
    self.class.base_uri host
  end

  def auth
    resp = self.class.head '/auth'
    @auth_token = resp.headers['badsec-authentication-token']
  end

  def users
    resp = self.class.get '/users', { headers: { 'X-Request-Checksum' => checksum('users') } }
    resp.body.split("\n")
  end

  private

  def checksum(path)
    auth if auth_token.nil?
    Digest::SHA256.hexdigest "#{@auth_token}/#{path}"
  end
end
