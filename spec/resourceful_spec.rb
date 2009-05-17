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
    get '/dog/breed/datsun'
    response.should be_ok
    response.body.should =~ /All dogs with a breed of datsun/
  end
end