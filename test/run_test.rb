require 'English'
require 'json'
require 'minitest/autorun'

def run_program(host: 'http://0.0.0.0:8888', extra_args: '')
  `BADSEC_HOST=#{host} #{extra_args} bundle exec ruby run.rb`
end

describe 'run' do

  it 'has status code of 0 on successfull run' do
    run_program

    assert $CHILD_STATUS.exitstatus.zero?
  end

  it 'outputs valid JSON array' do
    output = run_program
    array = JSON.parse(output)

    assert array.is_a?(Array)
  end

  it 'has non zero status code on unsuccessfull run' do
    run_program(host: 'invalid', extra_args: 'RUBYOPT="-W0"')

    assert !$CHILD_STATUS.exitstatus.zero?
  end
end
