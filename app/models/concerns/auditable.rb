require 'active_support/concern'

module Auditable
  extend ActiveSupport::Concern

  included do
    before_create do
      stamp_current_user(:created_by, :updated_by)
      stamp_changed_by
    end

    before_update do
      stamp_current_user(:updated_by)
      stamp_changed_by
    end
  end

  private

  def stamp_current_user(*attributes)
    user_id = Thread.current.thread_variable_get(:current_user_id)
    Array(attributes).each { |attribute| write_attribute(attribute, user_id) }
  end

  def stamp_changed_by
    changed_by = Thread.current.thread_variable_get(:changed_by)
    write_attribute(:changed_by, changed_by)
  end
end
