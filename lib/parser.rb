require 'CSV'
require File.join(File.dirname(__FILE__), 'resource')
require File.join(File.dirname(__FILE__), 'array')

class Parser
  attr_reader :csv_files
  
  def self.load
    parser = Parser.new
    parser.load
  end

  def initialize
    Dir.chdir(File.join(File.dirname(__FILE__), '..')) do
      @csv_files = Dir.glob(File.join("**", "csv", "**", "*.csv"))
    end
  end
  
  def load
    @csv_files.each do |file|
      file =~ /^csv\/(.*)[s|es].csv$/
      parse file, $1
    end
  end
  
  def parse(file, model_name)
    attributes = []
    path_to_file = File.join(File.dirname(__FILE__), '..', file)

    CSV.open(path_to_file, 'r') do |row|
      if attributes.empty?
        attributes = row.symbolize
        if model = create_model(model_name)
          model.define_attributes(*attributes)
        end
      else
        object = Object.const_get(model_name.capitalize).new
        attributes.zip(row.symbolize).each do |attribute, value|
          object.send("#{attribute}=", value)
        end
      end
    end
  end

private

  def create_model(model_name)
    model_name = model_name.capitalize
    return false if Object.const_defined?(model_name)

    Object.const_set model_name, Class.new(Resource)
  end
end