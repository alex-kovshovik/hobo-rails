class ApplicationRecord < ActiveRecord::Base
  include Auditable

  self.abstract_class = true
end
