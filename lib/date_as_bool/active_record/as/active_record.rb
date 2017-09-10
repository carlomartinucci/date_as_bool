ActiveSupport.on_load :active_record do
  extend ActiveRecord::As::Bool::ClassMethods
end