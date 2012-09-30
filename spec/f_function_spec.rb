require File.join(File.dirname(__FILE__), *%w[.. src f_function])

describe FFunction do

  it 'gives appropriate 8 bit output taking 6 bit message and 8 bit key' do
    r = [1,0,0,1,1,0]
    k_i = [0,1,1,0,0,1,0,1]
    f = FFunction.new
    f.calculate(r, k_i).should == [0,0,0,1,0,0]
    puts f.calculate([0,0,0,1,1,1], [0,0,1,0,0,1,1,0])
  end

end
