require File.join(File.dirname(__FILE__), *%w[.. src key])

describe Key do

  it "knows any i-th key" do
    keyset = Key.new([0,1,0,0,1,1,0,0,1])

    keyset.calculate(1).should == [0,1,0,0,1,1,0,0]
    keyset.calculate(4).should == [0,1,1,0,0,1,0,1]
    keyset.calculate(9).should == [1,0,1,0,0,1,1,0]
  end

  it "raises an error if input is in a bad format" do
    lambda {Key.new("101010101")}.should raise_error
    lambda {Key.new(["1","0","1","0","1","0","1","0","1"])}.should raise_error
  end

end
