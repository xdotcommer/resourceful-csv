require File.join(File.dirname(__FILE__), '..', 'lib', 'array')
require 'spec'

describe Array do
  describe "symbolize" do
    it "should turn it's elements into symbols" do
      ["oe", "two", "thre ee"].symbolize.should == [:oe, :two, :thre_ee]
    end
  end
end