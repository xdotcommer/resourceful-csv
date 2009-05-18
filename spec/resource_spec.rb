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
  
  describe "dynamic finder" do
    before(:all) do
      class Person < Resource ; end ; 
      Person.define_attributes(:name, :age)
      [["Mike", 22], ["Amy", 36], ["Jose", 49], ["Jamie", 22], ["Niko", 34], ["Stewie", 2]].each do |pair|
        person      = Person.new
        person.name = pair[0]
        person.age  = pair[1]
      end
    end    
    it "should find resources by attribute and value" do
      niko = Person.find_by_name("Niko")
      niko.name.should == "Niko"
      niko.age.should == 34
    end
  end
  
  describe "to_xml" do
    before(:all) do
      class Stuff < Resource ; end ; 
      Stuff.define_attributes(:one, :two)
      @stuff     = Stuff.new
      @stuff.one = "fun"
      @stuff.two = "blue"
    end
    
    it "should output valid xml" do
      @stuff.to_xml.should =~ /^<\?xml version="1.0" encoding="UTF-8"\?>/
    end
    
    it "should output the resource" do
      @stuff.to_xml.should =~ /<Stuff>\s*<one>fun<\/one>\s*<two>blue<\/two>\s*<\/Stuff>$/
    end
  end
end