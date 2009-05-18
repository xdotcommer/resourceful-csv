class Resource
  def self.define_attributes(*attrs)
    attrs.each do |attribute|
      class_eval do
        define_method(attribute) do
          instance_variable_get("@#{attribute}")
        end
      
        define_method("#{attribute}=") do |value|
          instance_variable_set("@#{attribute}", value)
        end
      end
    end
  end
end