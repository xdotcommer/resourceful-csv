require 'spec'

describe "Dependencies (gems)" do
  it "should have rubygems" do
    lambda { require 'rubygems' }.should_not raise_error
  end
  
  it "should have sinatra" do
    lambda { require 'sinatra' }.should_not raise_error
  end
end