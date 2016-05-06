require 'system'

module ActiveRecord
  module Stamps
    def self.included(base)
      base.class_eval do
        extend ClassMethods
        alias_method_chain :_create_record, :stamps
        alias_method_chain :_update_record, :stamps
      end
    end

    def _create_record_with_stamps
      set_creator if record_user_stamp && System.current_user
      set_process if record_process_stamp

      _create_record_without_stamps
    end

    def _update_record_with_stamps
      set_updater if record_user_stamp && changed? && System.current_user
      set_process if record_process_stamp

      _update_record_without_stamps
    end

    private

    def set_creator
      write_attribute(:created_by, System.current_user.id) if respond_to?(:created_by) && created_by.nil?
      set_updater
    end

    def set_updater
      write_attribute(:updated_by, System.current_user.id) if respond_to?(:updated_by)
    end

    def set_process
      write_attribute(:changed_by, System.current_process || 'Unknown') if respond_to?(:changed_by)
    end
  end

  #--------------------------------------------------------------------------------------------------------
  # Class methods
  #--------------------------------------------------------------------------------------------------------
  module ClassMethods
    # rubocop:disable MethodLength
    def without_stamps(options = { userstamp: false, process_stamp: false, timestamp: false })
      current_user_stamp = ActiveRecord::Base.record_user_stamp
      current_process_stamp = ActiveRecord::Base.record_process_stamp
      current_time_stamp = ActiveRecord::Base.record_timestamps

      ActiveRecord::Base.record_user_stamp = options[:userstamp] unless options[:userstamp].nil?
      ActiveRecord::Base.record_process_stamp = options[:process_stamp] unless options[:process_stamp].nil?
      ActiveRecord::Base.record_timestamps = options[:timestamp] unless options[:timestamp].nil?

      yield

    ensure
      ActiveRecord::Base.record_user_stamp = current_user_stamp
      ActiveRecord::Base.record_process_stamp = current_process_stamp
      ActiveRecord::Base.record_timestamps = current_time_stamp
    end
  end

  class Base
    cattr_accessor(:record_user_stamp) { true }
    cattr_accessor(:record_process_stamp) { true }
  end
end
