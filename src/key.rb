require File.join(File.dirname(__FILE__), *%w[ bitwise_array ])

class Key
  include BitwiseArray

  def initialize(key)
    validate_int_ary(key)
    @key = key
  end

  def calculate(round)
    raise RoundOutOfBoundException.new(round), "Round #{round} not valid" if round == 0
    key_size = @key.size - 1
    starting_bit = round - 1
    key_i = []
    for i in 0..key_size
      circular_shift_bit_position = (i + starting_bit) % @key.size
      key_i[i]= @key[circular_shift_bit_position]
    end
    return key_i[0...key_size]
  end


  class RoundOutOfBoundException < RuntimeError
    attr_reader :round
    def initialize(round)
      @round = round
    end
  end

end
