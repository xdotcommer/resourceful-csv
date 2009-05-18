require File.join(File.dirname(__FILE__), '..', 'lib', 'parser')
require 'spec'

describe Parser do
  describe "new" do
    it "finds all the csv files" do
      Parser.new.csv_files.should == ["csv/cats.csv", "csv/dogs.csv"]
    end
  end

  describe "load" do
    before(:each) do
      Parser.load
    end
    
    after(:each) do
      # undefine the generated classes, methods, and objects???
    end

    describe "object creation" do
      it "should create an object for each line in the csv file" do
        ObjectSpace.each_object(Cat) {|cat|  }.should == 4
      end
      
      it "should assign the proper attributes" do
        ObjectSpace.each_object(Cat) do |cat|
          if cat.name == "Banker Cat"
            cat.saying.should == "banker cat is not amused"
          end
        end
      end
    end
    
    describe "model creation" do
      it "should create models based on csv filename" do
        Cat.class.should == Class
        Dog.class.should == Class
      end
      
      it "should create models that inherit from Resource" do
        Cat.new.is_a?(Resource).should be_true
        Dog.new.is_a?(Resource).should be_true
      end
    end
    
    describe "attribute assignment" do
      it "should create attributes for each column heading" do
        [:name, :color, :saying].each do |attribute|
          Cat.method_defined?(attribute).should be_true
        end

        [:name, :breed, :color].each do |attribute|
          Dog.method_defined?(attribute).should be_true
        end
      end
      
      it "should be unique to the subclass" do
        lambda { Dog.new.hair_length }.should raise_error
        lambda { Cat.new.breed }.should raise_error
      end
    end
  end
end