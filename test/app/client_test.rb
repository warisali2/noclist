require 'minitest/autorun'

require_relative '../../app/client'

describe Client do
  before do
    @client = Client.new('http://0.0.0.0:8888')
  end

  it 'gets auth from host' do
    @client.auth
    refute @client.auth_token.nil?
  end

  it 'gets users from host' do
    users = @client.users
    assert users.is_a? Array
  end
end
