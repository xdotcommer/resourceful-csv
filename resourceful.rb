require 'rubygems'
require 'sinatra'

get '/:resource/:attribute/:value' do |resource, attribute, value|
  "All #{resource}s with a #{attribute} of #{value}:"
end

get '/:resource' do |resource|
  "List all #{resource}s"
end
