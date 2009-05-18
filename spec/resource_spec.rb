require File.join(File.dirname(__FILE__), '..', 'lib', 'resource')
require 'spec'

describe Resource do
  describe "define_attributes" do
    before(:each) do
      @resource            = Resource.new
      class SomeResource < Resource ; end
      class SomeOtherResource < Resource ; end
      @some_other_resource = SomeOtherResource.new
    end
    
    it "should define a setter" do
      Resource.define_attributes(:name, :rank, :serial_number)
      [:name=, :rank=, :serial_number=].each do |attribute|
        Resource.method_defined?(attribute).should be_true
      end
    end
    
    it "should define a getter" do
      Resource.define_attributes(:name, :rank, :serial_number)
      [:name, :rank, :serial_number].each do |attribute|
        Resource.method_defined?(attribute).should be_true
      end
    end
    
    it "should store the value" do
      Resource.define_attributes(:name, :rank, :serial_number)
      @resource.name = "Bob"
      @resource.name.should == "Bob"
    end
    
    describe "subclassing" do
      it "should work for subclasses" do
        SomeResource.define_attributes(:some_attr)
        SomeResource.method_defined?(:some_attr).should be_true
        SomeResource.method_defined?(:some_attr=).should be_true
      end
    
      it "should not define across subclasses" do
        SomeResource.define_attributes(:some_attr)
        SomeOtherResource.method_defined?(:some_attr).should be_false
        SomeOtherResource.method_defined?(:some_attr=).should be_false
      end
    end
  end
end