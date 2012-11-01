require "occurro/engine"
require "occurro/tasks"
require "occurro/has_counters"
require "occurro/cached_counter"
require "occurro/cached_session"
require "occurro/jobs/sender"
require "occurro/jobs/resque"
require 'occurro/jobs/delayed_job'

module Occurro
  mattr_accessor :custom_job
  @@custom_job = false

  # Global configuration
  # Options:
  #
  # * custom_job= #=> Defaults to false
  #                   Accepts :resque, :delayed_job or a custom proc(model, count)
  #     
  #     false will make a synchronous call to the model and increment the counter
  #     :resque will enqueue a simple job to increment the counter in Resque
  #     :delayed_job will do the same, but for DelayedJob
  #     a custom proc (or a class that accepts call) will call this instead,
  #     you can use it to create a custom job for resque, delayed_job, or any other
  #
  # Example:
  #
  #   Occurro.configure do |config|
  #     config.custom_job = :resque
  #   end
  #
  def self.configure
    yield(self)
  end

  private

  def self.custom_job=(job)
    @@custom_job = job
  end
end
