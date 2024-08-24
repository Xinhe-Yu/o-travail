class ApplicationRecord < ActiveRecord::Base
  include SharedMethods
  primary_abstract_class

end
