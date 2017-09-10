class ApplicationRecord < ActiveRecord::Base
  include DateAsBool

  self.abstract_class = true
end
