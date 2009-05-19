require 'rubygems'
require 'sinatra'
require 'lib/resource'
require 'lib/parser'

Parser.load

get '/:resource/:attribute/:value' do |resource, attribute, value|
  content_type 'text/xml'

  klass = Kernel.const_get(resource.capitalize)
  model = klass.send("find_by_#{attribute}", value)
  model.to_xml
end

get '/:resource' do |resource|
  "List all #{resource}s"
end
