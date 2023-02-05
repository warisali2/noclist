require 'minitest/autorun'

require_relative '../../../app/client/retry_block'

describe RetryBlock do
  include RetryBlock

  it 'calls the given block' do
    call_count = 0
    retry_block { call_count = 1 }
    assert call_count == 1
  end

  it 'retries the block by given count' do
    call_count = 0

    retry_block(retry_count: 2) do
      call_count += 1
      raise 'Error' if call_count < 3
    end rescue nil

    assert call_count == 3
  end

  it 'raises error after retries' do
    call_count = 0

    begin
      retry_block(retry_count: 2) do
        call_count += 1
        raise 'Error' if call_count < 3
      end
    rescue StandardError => e
      assert e.message == 'Error'
    end

    assert call_count == 3
  end

end
