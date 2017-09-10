module ActiveRecord
  module As #:nodoc:
    module Bool #:nodoc:

      module ClassMethods
        def date_as_bool datetime_name, bool_name=nil
          caller_class = self

          if bool_name.nil?
            bool_name = datetime_name.to_s.split("_")[0..-2].join("_").to_sym
          end

          caller_class.class_eval do
            attr_accessor bool_name
            define_method bool_name do
              self.send(datetime_name).present?
            end
            define_method :"#{bool_name}=" do |bool|
              self.send(:"#{datetime_name}=", bool ? Time.now : nil)
            end
            define_method :"#{bool_name}!" do
              self.send(:"#{bool_name}=", true)
              self.save!
            end
            define_method :"#{bool_name}?" do
              self.send(bool_name)
            end
          end

        end
      end
    end
  end
end