require File.join(File.dirname(__FILE__), *%w[.. src bitwise_array])
include BitwiseArray

describe  BitwiseArray do

  it "returns an array containing the bits of the given arrays xored" do
    array_a = [1,0,1,0,1,0,1,0]
    array_b = [0,1,1,0,0,1,0,1]

    BitwiseArray::xor(array_a, array_b).should == [1,1,0,0,1,1,1,1]

    array_a = [0,0,1,0,1,0,1,0]
    array_b = [0,1,1,0,0,1,0,0]

    BitwiseArray::xor(array_a, array_b).should == [0,1,0,0,1,1,1,0]
  end

  describe "converts array from string to int" do
    it "converts an array of string of 0 and 1 into an array of fixnum of 0 and 1" do
      ary_str_to_ary_int(["1","0","1"]).should == [1,0,1]
    end

    it "raises an error if the array to convert isn't an array of 0-1 string" do
      lambda { ary_str_to_ary_int(["a","b"]) }.should raise_error
    end
  end

  describe "validates array format" do
    it "returns true if array is in the expected format" do
      validate_string_ary(["1","0","1"]).should be_true
      validate_int_ary([1,0,1]).should be_true
    end

    it "raises an error if the array isn't in the expected format" do
      lambda { validate_string_ary(["a","b"]) }.should raise_error
      lambda { validate_string_ary([1,0]) }.should raise_error
      lambda { validate_string_ary(["3","4"]) }.should raise_error

      lambda { validate_int_ary([2,4,3]) }.should raise_error
      lambda { validate_int_ary(["1","0"]) }.should raise_error
    end
  end

end
