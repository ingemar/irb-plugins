# frozen_string_literal: true

return unless defined?(ApplicationRecord)

# Find long running queries

class PgStatActivity < ActiveRecord::Base
  self.table_name = "pg_stat_activity"

  # Usage:
  # > PgStatActivity.started_before(1.minute.ago)
  # => [#<PgStatActivity:0x00007f9060f3c440 datid: 16416, ...>, ...]
  scope :started_before, ->(time) { where("xact_start < ?", time) }
end
