require File.join(File.dirname(__FILE__), *%w[f_function])
require File.join(File.dirname(__FILE__), *%w[bitwise_array])

class Round
  include BitwiseArray

  def initialize(message, key)
    raise RuntimeError, "Message isn't an array of fixnum" if message.class != Array or message[0].class != Fixnum
    raise RuntimeError, "Key isn't an array of fixnum" if key.class != Array or key[0].class != Fixnum
    @l_half = message[0...message.size/2]
    @r_half = message[message.size/2...message.size]
    @key = key
  end

  def calculate
    f = FFunction.new
    f_output = f.calculate(@r_half, @key)

    r_i = xor(f_output, @l_half)
    l_i = @r_half

    return l_i + r_i
  end

end
