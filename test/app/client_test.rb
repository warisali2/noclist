require 'minitest/autorun'

require_relative '../../app/client'

describe Client do
  before do
    @client = Client.new('http://0.0.0.0:8888')
  end

  it 'gets auth from host' do
    @client.auth
    assert_not @client.auth_token.nil?
  end
end
