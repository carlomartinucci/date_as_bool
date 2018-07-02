module ActiveRecord
  module As #:nodoc:
    module Bool #:nodoc:
      module ClassMethods #:nodoc:
        def date_as_bool(datetime_name, bool_name = nil)
          bool_name ||= datetime_name.to_s.split('_')[0..-2].join('_').to_sym

          singleton_class.class_eval do
            define_method bool_name do
              where.not(datetime_name => nil)
            end
            define_method "not_#{bool_name}" do
              where(datetime_name => nil)
            end
          end

          class_eval do
            define_method bool_name do
              send(datetime_name).present?
            end
            define_method :"#{bool_name}?" do
              send(bool_name)
            end
            define_method :"#{bool_name}=" do |bool|
              send(:"#{datetime_name}=", bool ? Time.now : nil)
            end
            define_method :"#{bool_name}!" do
              send(:"#{bool_name}=", true)
              save!
            end
          end
        end
      end
    end
  end
end
