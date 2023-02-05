module RetryBlock
  def retry_block(retry_count: 1, &blk)
    count = 0

    begin
      blk.call
    rescue StandardError => e
      raise e if count >= retry_count

      count += 1

      warn "\n#{e.class}: #{e.message}"
      warn "Retrying (#{count}/#{retry_count})"

      retry
    end
  end
end