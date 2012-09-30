require File.join(File.dirname(__FILE__), *%w[bitwise_array])

class FFunction
  include BitwiseArray

  def calculate(r, k_i)
    expanded_r = expander(r)

    xored = xor(expanded_r, k_i)

    l_half = sbox_magic(SBOX_1, xored[0..3])
    r_half = sbox_magic(SBOX_2, xored[4..7])

    return l_half + r_half
  end

  private

    def expander(six_bit)
      e = six_bit
      return e[0..1] << e[3] << e[2] << e[3] << e[2] << e[4] << e[5]
    end

    def sbox_magic(sbox, half_xored)
      row = half_xored[0]
      column_string = ""
      half_xored[1..3].each { |bit| column_string += bit.to_s }
      column = column_string.to_i(2)
      l_half = sbox[row][column]
    end

    SBOX_1 = [
      [[1,0,1], [0,1,0], [0,0,1], [1,1,0], [0,1,1], [1,0,0], [1,1,1], [0,0,0]],
      [[0,0,1], [1,0,0], [1,1,0], [0,1,0], [0,0,0], [1,1,1], [1,0,1], [0,1,1]]
    ]
    SBOX_2 = [
      [[1,0,0], [0,0,0], [1,1,0], [1,0,1], [1,1,1], [0,0,1], [0,1,1], [0,1,0]],
      [[1,0,1], [0,1,1], [0,0,0], [1,1,1], [1,1,0], [0,1,0], [0,0,1], [1,0,0]]
    ]

end
