module Platform
    module Concerns
        module ActsAsCurrent
            extend ActiveSupport::Concern

            included do
                self._klass_name = self.name.underscore.to_sym
            end

            def make_current
                Thread.current[self.class._klass_name] = self
            end
           
            module ClassMethods

                attr_accessor :_klass_name
                
                def current
                    Thread.current[_klass_name]
                end
                
                def reset_current
                    Thread.current[_klass_name] = nil
                end
            end
        end
    end
end