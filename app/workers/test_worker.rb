class TestWorker
  @queue = :default

  def self.perform
    puts "Test Worker Completed"
  end
end
