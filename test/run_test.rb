require 'English'
require 'json'
require 'minitest/autorun'

describe 'run' do
  run_program = ->(host = 'http://0.0.0.0:8888') { `BADSEC_HOST=#{host} bundle exec ruby run.rb` }

  it 'has status code of 0 on successfull run' do
    run_program.call
    assert $CHILD_STATUS.exitstatus.zero?
  end

  it 'outputs valid JSON array' do
    output = run_program.call
    array = JSON.parse(output)
    assert array.is_a?(Array)
  end

  it 'has non zero status code on unsuccessfull run' do
    run_program.call('nil')

    assert !$CHILD_STATUS.exitstatus.zero?
  end
end
