require "occurro/engine"
require "occurro/tasks"
require "occurro/has_counters"
require "occurro/jobs/sender"
require "occurro/jobs/resque"
require 'occurro/jobs/delayed_job'

module Occurro
  mattr_accessor :custom_job
  @@custom_job = false
end
