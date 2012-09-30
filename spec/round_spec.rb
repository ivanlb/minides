require File.join(File.dirname(__FILE__), *%w[.. src round])

describe Round do

  it 'gives Li Ri given Li-1 Ri-1 and Ki' do
    message_i = [0,1,1,1,0,0,1,0,0,1,1,0]
    k_i = [0,1,1,0,0,1,0,1]
    round = Round.new(message_i, k_i)

    round.calculate.should == [1,0,0,1,1,0,0,1,1,0,0,0]
  end

end
