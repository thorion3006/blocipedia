class ApplicationRecord < ActiveRecord::Base
  require 'attr_default'
  self.abstract_class = true
end
