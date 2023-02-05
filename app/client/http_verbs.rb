require_relative './retry_block'

module HTTPVerbs
  include RetryBlock

  %i[head get].each do |method|
    define_method method do |*args|
      retry_block retry_count: 2 do
        response = self.class.send(method, *args)
        return response if response.code == 200

        raise HTTPRequestFailed
      end
    end
  end
end
