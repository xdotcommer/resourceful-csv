require File.join(File.dirname(__FILE__), '..', 'resourceful')  # <-- your sinatra app
require 'spec'
require 'spec/interop/test'
require 'sinatra/test'

set :environment, :test

describe 'The Resourceful App' do
  include Sinatra::Test

  it "lists resources" do
    get '/dog'
    response.should be_ok
    response.body.should == 'List all dogs'
  end
  
  it "finds resources based on attribute / value" do
    get '/dog/breed/bulldog'
    response.should be_ok
    response.content_type.should == 'text/xml'
    response.body.should =~ /^<\?xml version="1\.0" encoding="UTF-8"\?>\s*<Dog>/
    response.body.should =~ /<age>4<\/age>/
    response.body.should =~ /<color>white<\/color>/
    response.body.should =~ /<breed>bulldog<\/breed>/
    response.body.should =~ /<name>Fido<\/name>/
    response.body.should =~ /<\/Dog>\s*$/
  end
end