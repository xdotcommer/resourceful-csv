require 'builder'

class Resource
  def self.define_attributes(*attrs)
    class_variable_set(:@@attributes, attrs)
    
    attrs.each do |attribute|
      class_eval do
        def attributes
          @@attributes
        end
        
        define_method(attribute) do
          instance_variable_get("@#{attribute}")
        end
      
        define_method("#{attribute}=") do |value|
          instance_variable_set("@#{attribute}", value)
        end
      end
    end
  end
  
  def self.method_missing(finder, *args)
    super unless finder.to_s =~ /^find_by_(.*)/
    attribute, value = $1, args[0]
    
    ObjectSpace.each_object(self) do |resource|
      return resource if resource.send(attribute).to_s == value
    end
  end
  
  def to_xml
    xml = '<?xml version="1.0" encoding="UTF-8"?>'
    xml << "\n<#{self.class.to_s}>\n"
    xml << "#{attribute_xml}</#{self.class.to_s}>"
  end
  
private
  def attribute_xml
    xml = ""
    instance_variables.each do |attribute|
      tag = attribute.gsub(/^@/, '')
      xml << "\t<#{tag}>#{instance_variable_get(attribute)}</#{tag}>\n"
    end
    xml
  end
end