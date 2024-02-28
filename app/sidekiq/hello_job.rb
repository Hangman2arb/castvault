class HelloJob
  include Sidekiq::Job

  def perform(*_args)
    puts 'hello world'
  end
end
